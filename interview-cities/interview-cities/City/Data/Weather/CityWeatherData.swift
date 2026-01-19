struct CityWeatherData: Decodable {
    let weatherUnits: WeatherUnits
    let weather: Weather
    
    enum CodingKeys: String, CodingKey {
        case weatherUnits = "current_weather_units"
        case weather = "current_weather"
    }
    
    struct WeatherUnits: Decodable {
        let temperature: String
    }
    
    struct Weather: Decodable {
        let temperature: Double
        let weathercode: Int
    }
}
