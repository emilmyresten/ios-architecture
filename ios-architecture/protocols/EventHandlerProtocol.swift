@MainActor
protocol EventHandlerProtocol {
    func handleEvent(event: Event) async
}
