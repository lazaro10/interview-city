import SwiftUI

enum CityBuilder {
    static func build() -> CityView {
        let viewModel = CityViewModel(
            cityRepository: CityRepository(),
            cityWeatherRepository: CityWeatherRepository()
        )
        
        return CityView(viewModel: viewModel)
    }
}
