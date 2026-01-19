import Foundation

protocol CityRepositoryLogic {
    func fetchCities(name: String) async throws -> CityData
}

final class CityRepository: CityRepositoryLogic {
    private let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchCities(name: String) async throws -> CityData {
        do {
            let request = CityRequest(name: name)
            let result: CityData = try await network.request(request)
            return result
        } catch {
            throw error
        }
    }
}
