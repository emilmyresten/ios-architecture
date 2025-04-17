
@MainActor
class MockClient: APIProtocol {
    func getResource(_ input: Operations.getResource.Input) async throws -> Operations.getResource.Output {
        try await Task.sleep(for: .seconds(1))
        return .ok(.init(body: .json(.init(text: "Hello, World!"))))
    }
}
