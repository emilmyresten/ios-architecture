import Foundation

@MainActor
class NetworkService {
    private let httpClient: APIProtocol
    
    init(httpClient: APIProtocol) {
        self.httpClient = httpClient
    }
    
    func getResource() async throws -> Components.Schemas.GetResourceResponse {
        let response = try await httpClient.getResource()
        switch response {
        case let .ok(r):
            switch r.body {
            case let .json(body):
                return body
            }
        case .undocumented(let statusCode, _):
            throw AppError.network(statusCode: statusCode)
        }
    }
}
