import SwiftUI

struct ContentView: View {

    let viewModel: ViewModel

    var body: some View {
        switch viewModel.loadingState {
        case .idle:
            Color.clear.onAppear {
                print("initializer onAppear fired")
                Task {
                    await EventBus.sendEvent(event: .pageAppeared)
                }
            }
        case .loading:
            ProgressView()
        case .error:
            Text("error")
        case .loaded:
            if let t = viewModel.networkResponse?.text,
                viewModel.textVisiblep == true
            {
                Text(t)
                    .task {
                        print("task fired")
                    }
                    .onAppear {
                        print("onAppear fired")
                    }
                    .onDisappear {
                        print("onDisappear fired")
                    }
            }
            Button("toggle visibility") {
                Task {
                    await EventBus.sendEvent(event: .toggleVisibilityButtonPressed)
                }
            }
            .frame(width: 200, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.gray)
            )
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ContentView(
        viewModel: ViewModel(
            networkService: NetworkService(httpClient: MockClient())
        )
    )
}
