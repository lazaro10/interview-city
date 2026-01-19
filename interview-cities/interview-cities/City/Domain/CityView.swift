import SwiftUI

struct CityView: View {
    @State private var viewModel: CityViewModel
    @State private var query: String = ""

    init(viewModel: CityViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        @Bindable var vm = viewModel

        VStack(spacing: 16) {
            HStack(spacing: 12) {
                TextField("Search city", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled(true)
                    .onSubmit { vm.search(query: query) }

                Button("Search") { vm.search(query: query) }
                    .buttonStyle(.borderedProminent)
                    .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading(vm.state))
            }

            content(for: vm.state)

            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    private func content(for state: CityViewModel.State) -> some View {
        switch state {
        case .idle:
            Text("Type a city name and tap Search.")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

        case .loading:
            HStack(spacing: 12) {
                ProgressView()
                Text("Loading...")
                    .foregroundStyle(.secondary)
            }

        case .failed(let message):
            VStack(alignment: .leading, spacing: 8) {
                Text("Error")
                    .font(.headline)

                Text(message)
                    .foregroundStyle(.secondary)

                Button("Try again") {
                    viewModel.search(query: query)
                }
                .buttonStyle(.bordered)
                .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }

        case .loaded(let display):
            VStack(alignment: .leading, spacing: 8) {
                Text(display.name)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Temperature: \(display.temperature)")
                Text("Weathercode: \(display.weathercode)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func isLoading(_ state: CityViewModel.State) -> Bool {
        if case .loading = state { return true }
        return false
    }
}
