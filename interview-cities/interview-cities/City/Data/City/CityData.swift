struct City: Decodable {
    let results: [Data]
    
    struct Data: Decodable{
        let name: String
        let latitude: Double
        let longitude: Double
    }
}
