import Foundation

protocol NetworkClient: Sendable {
    func request<T: Decodable>(
        _ requester: NetworkRequester
    ) async throws -> T
}
