import Foundation

protocol CityRepositoryLogic {
    func fetchCities(name: String) async -> [City]
}

final class CityRepository: CityRepositoryLogic {
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func fetchCities(name: String) async -> [City] {
        do {
            let result: [City] = try await network.request(url: URL.init(string: "https://geocoding-api.open-meteo.com/v1/search?name=\(name)")!)
            return result
        } catch {
            return []
        }
    }
}
