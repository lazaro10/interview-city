import Foundation
import Combine

@MainActor
final class CityViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var temperature: String = ""
    @Published var weathercode: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let cityRepository: CityRepositoryLogic
    private let cityWeatherRepository: CityWeatherRepositoryLogic

    init(
        cityRepository: CityRepositoryLogic,
        cityWeatherRepository: CityWeatherRepositoryLogic
    ) {
        self.cityRepository = cityRepository
        self.cityWeatherRepository = cityWeatherRepository
    }

    func getCityWeather(name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                guard let city = try await cityRepository.fetchCities(name: trimmed).results.first else {
                    return
                }
                
                let weather = try await cityWeatherRepository.fetchWeather(city: city)
                
                self.name = city.name
                self.temperature = "\(weather.weather.temperature) \(weather.weatherUnits.temperature)"
                self.weathercode = "\(weather.weather.weathercode)"
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
