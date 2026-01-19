import Foundation

struct CityRequest: NetworkRequester {
    let url: String
    let method: HTTPMethod = .get

    init(name: String) {
        self.url = "https://geocoding-api.open-meteo.com/v1/search?name=\(name)"
    }
}
