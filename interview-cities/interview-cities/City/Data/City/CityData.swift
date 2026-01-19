struct CityData: Decodable {
    let results: [City]
    
    struct City: Decodable{
        let name: String
        let latitude: Double
        let longitude: Double
    }
}
