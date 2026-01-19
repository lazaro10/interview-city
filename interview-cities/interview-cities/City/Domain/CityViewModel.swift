import Foundation
import Observation

@MainActor
@Observable
final class CityViewModel {

    enum State: Equatable {
        case idle
        case loading
        case loaded(Display)
        case failed(String)
    }

    struct Display: Equatable {
        let name: String
        let temperature: String
        let weathercode: String
    }

    private let cityRepository: CityRepositoryLogic
    private let cityWeatherRepository: CityWeatherRepositoryLogic

    private(set) var state: State = .idle

    private var searchTask: Task<Void, Never>?

    init(
        cityRepository: CityRepositoryLogic,
        cityWeatherRepository: CityWeatherRepositoryLogic
    ) {
        self.cityRepository = cityRepository
        self.cityWeatherRepository = cityWeatherRepository
    }

    func search(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            state = .idle
            return
        }

        searchTask?.cancel()
        state = .loading

        searchTask = Task { [weak self] in
            guard let self else { return }

            do {
                let response = try await cityRepository.fetchCities(name: trimmed)

                guard let city = response.results.first else {
                    state = .failed("City not found.")
                    return
                }

                let weather = try await cityWeatherRepository.fetchWeather(city: city)

                state = .loaded(
                    .init(
                        name: city.name,
                        temperature: "\(weather.weather.temperature) \(weather.weatherUnits.temperature)",
                        weathercode: "\(weather.weather.weathercode)"
                    )
                )
            } catch is CancellationError {
                return
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }
}
