//
//  CountryList.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import SwiftUI
import CountryListUseCase
import WorldViewCoreKit

struct CountryList: View {

    @State var viewModel: CountryListViewModel
    @State var selectedCountry: Country?

    var body: some View {
        content
            .searchable(text: .init(get: {
                viewModel.search
            }, set: {
                viewModel.updateSearch(text: $0)
            }))
            .navigationTitle("Contry List")
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.loadingState {
        case .loading:
            loadingIndicator
        case let .loaded(countries):
            list(for: countries)
        case let .searching(filteredCountries, _):
            list(for: filteredCountries)
        case .failed:
            emptyStateView(title: "An Unknow Error has occured", message: "We were unable to get the country list. You can always try to reload it.")
        }
    }

    private func emptyStateView(title: String, message: String) -> some View {
        VStack {
            Text(title)
                .font(.title3.bold())
            Text(message)
                .multilineTextAlignment(.center)
                .padding([.bottom, .horizontal])
            Button {
                Task {
                    await viewModel.fetchCountries()
                }
            } label: {
                Text("Reload")
                    .frame(width: 128, height: 44)
                    .overlay {
                        Capsule().stroke(lineWidth: 1)
                    }
            }
        }
        .padding()
        .foregroundColor(.secondary)
    }

    private var loadingIndicator: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text("Loading in progress")
                .foregroundStyle(.secondary)
        }
        .task {
            await viewModel.fetchCountries()
        }
    }

    @ViewBuilder
    private func list(for countries: [Country]) -> some View {
        List(countries) { country in
            Button { viewModel.didSelect(country: country) } label: {
                CountryListItemView(viewModel: viewModel.viewModel(for: country))
            }
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    CountryList(viewModel: CountryListViewModel(useCase: CountryListUseCase(dataSource:  CountriesPreviewDataSource())))
}

#Preview {
    CountryList(viewModel: CountryListViewModel(useCase: CountryListUseCase(dataSource: CountriesPreviewDataSource(countries: []))))
}

#Preview {
    CountryList(viewModel: CountryListViewModel(useCase: CountryListUseCase(dataSource: CountriesPreviewDataSource(delay: 3600))))
}

#Preview {
    CountryList(viewModel: CountryListViewModel(useCase: CountryListUseCase(dataSource: ForcedFailureApiClient(error: .decodingFailed))))
}
