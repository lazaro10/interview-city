import Foundation

protocol CityRepositoryLogic {
    func fetchCities(name: String) async throws -> [City]
}

final class CityRepository: CityRepositoryLogic {
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func fetchCities(name: String) async throws -> [City] {
        do {
            let request = CityRequest(name: name)
            let result: [City] = try await network.request(request)
            return result
        } catch {
            throw error
        }
    }
    
    func fetchWeather(city: City) async throws -> []
}
