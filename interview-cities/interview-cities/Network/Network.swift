import Foundation

enum NetworkError: Error {
    case invalidURL
}

final class Network {
    func request<T: Decodable>(url: URL?) async throws -> T {
        guard let url = url else {
            throw NetworkError.invalidURL
        }
        
        let data = try await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        
        let result = try jsonDecoder.decode(T.self, from: data.0)
        
        return result
    }
}
