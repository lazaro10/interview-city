import Foundation

struct CityWeatherRequest: NetworkRequester {
    let url: String
    let method: HTTPMethod = .get

    init(city: CityData.City) {
        self.url = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current_weather=true"
    }
}
