@MainActor
class EventBus {

    static private var subscribers: [() -> (any EventHandlerProtocol)?] = []

    static func subscribe(
        _ subscriber: @escaping () -> (any EventHandlerProtocol)?
    ) {
        subscribers.append(subscriber)
    }

    static func unsubscribe(
        _ caller: any EventHandlerProtocol
    ) {
        let callerId = ObjectIdentifier(caller as AnyObject)
        self.subscribers = subscribers.filter { subscriberCallback in
            guard let subscriber = subscriberCallback() else {
                return false
            }

            let subscriberId = ObjectIdentifier(subscriber as AnyObject)
            return subscriberId != callerId
        }
    }

    static func sendEvent(event: Event) async {
        for subscriber in subscribers {
            await subscriber()?.handleEvent(event: event)
        }
    }

}
