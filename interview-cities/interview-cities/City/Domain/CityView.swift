import SwiftUI

struct CityView: View {
    @StateObject private var viewModel: CityViewModel
    @State private var query: String = ""

    init(viewModel: CityViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                TextField("Search city", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled(true)
                    .onSubmit { search() }

                Button("Search") { search() }
                    .buttonStyle(.borderedProminent)
                    .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
            }

            content

            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            HStack(spacing: 12) {
                ProgressView()
                Text("Loading...")
                    .foregroundStyle(.secondary)
            }
        } else if let message = viewModel.errorMessage {
            VStack(alignment: .leading, spacing: 8) {
                Text("Error")
                    .font(.headline)
                Text(message)
                    .foregroundStyle(.secondary)

                Button("Try again") { search() }
                    .buttonStyle(.bordered)
                    .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        } else if !viewModel.name.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Temperature: \(viewModel.temperature)")
                    .font(.body)

                Text("Weathercode: \(viewModel.weathercode)")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            Text("Type a city name and tap Search.")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func search() {
        viewModel.getCityWeather(name: query)
    }
}
