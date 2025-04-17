import SwiftUI

@MainActor @Observable
class ViewModel {

    let networkService: NetworkService

    var networkResponse: Components.Schemas.GetResourceResponse?
    var loadingState: NetworkLoadingState = .idle

    var textVisiblep: Bool = true

    init(networkService: NetworkService) {
        self.networkService = networkService
        EventBus.subscribe({ [weak self] in self })
    }

    func load() async {
        do {
            loadingState = .loading

            networkResponse = try await networkService.getResource()

            loadingState = .loaded
        } catch {
            print("some error occured: \(error)")
            loadingState = .error
        }
    }

}

extension ViewModel: EventHandlerProtocol {
    func handleEvent(event: Event) async {
        print("got event \(event)")
        switch event {
        case .pageAppeared:
            await load()

        case .toggleVisibilityButtonPressed:
            textVisiblep.toggle()

        }
    }

}
