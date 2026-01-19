import Foundation

final class Network: NetworkClient {
    private let session: HTTPSession
    private let decoder: JSONDecoder

    init(session: HTTPSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(
        _ requester: NetworkRequester,
       
    ) async throws -> T {
        let (data, _) = try await request(requester)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }

    private func request(_ requester: NetworkRequester) async throws -> (Data, HTTPURLResponse) {
        let request = try buildURLRequest(from: requester)
        let (data, response) = try await session.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.statusCode(http.statusCode, data)
        }

        return (data, http)
    }

    private func buildURLRequest(from requester: NetworkRequester) throws -> URLRequest {
        guard let url = URL(string: requester.url) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url, timeoutInterval: requester.timeout)
        request.httpMethod = requester.method.rawValue

        return request
    }
}
