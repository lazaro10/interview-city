import Foundation

protocol NetworkRequester: Sendable {
    var url: String { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval { get }
}

extension NetworkRequester {
    var timeout: TimeInterval { 30 }
}
