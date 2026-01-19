import Foundation

protocol CityWeatherRepositoryLogic {
    func fetchWeather(city: CityData.City) async throws -> CityWeatherData
}

final class CityWeatherRepository: CityWeatherRepositoryLogic {
    private let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchWeather(city: CityData.City) async throws -> CityWeatherData {
        do {
            let request = CityWeatherRequest(city: city)
            let result: CityWeatherData = try await network.request(request)
            return result
        } catch {
            throw error
        }
    }
}
