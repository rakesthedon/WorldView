//
//  CountryList.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import SwiftUI

struct CountryList: View {

    @ObservedObject var viewModel: CountryListViewModel

    var body: some View {
        NavigationView {
            if viewModel.loading {
                loadingIndicator
            } else if viewModel.error != nil {
                emptyStateView(title: "An Unknow Error has occured", message: "We were unable to get the country list. You can always try to reload it.")
            } else {
                countryList
            }
        }
        .task {
            await viewModel.fetchCountries()
        }
    }

    @ViewBuilder
    private var countryList: some View {
        if viewModel.countries.isEmpty {
            emptyStateView(title: "Nothing to see here", message: "Looks like the list is empty. You can try to reload the page later.")
        } else {
            list
        }
    }

    private var list: some View {
        List(viewModel.countries) { country in
            CountryListItemView(viewModel: viewModel.viewModel(for: country))
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
        ProgressView()
    }
}

#Preview {
    CountryList(viewModel: CountryListViewModel(apiClient: CountriesPreviewApiClient()))
}

#Preview {
    CountryList(viewModel: CountryListViewModel(apiClient: CountriesPreviewApiClient(countries: [])))
}


#Preview {
    CountryList(viewModel: CountryListViewModel(apiClient: CountriesPreviewApiClient(delay: 3600)))
}

#Preview {
    CountryList(viewModel: CountryListViewModel(apiClient: ForcedFailureApiClient(error: .decodingFailed)))
}
