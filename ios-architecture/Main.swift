import OpenAPIURLSession
import SwiftUI

@main
struct Main: App {
    let viewModel: ViewModel

    init() {
        let client = MockClient()
        let networkService = NetworkService(
            httpClient: client
        )
        self.viewModel = ViewModel(networkService: networkService)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
