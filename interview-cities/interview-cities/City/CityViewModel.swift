import SwiftUI

struct CityView: View {
    @StateObject var viewModel: CityViewModel
    
    var body: some View {
        Text(viewModel.name)
            .onAppear() {
                viewModel.getCity(name: "Lodon")
            }
    }
}
