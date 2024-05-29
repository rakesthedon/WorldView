//
//  ContentView.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import SwiftUI

struct WorldList: View {

    @ObservedObject var viewModel: WorldListViewModel

    var body: some View {
        NavigationView {
            countryList
        }
        .task {
            await viewModel.fetchCountries()
        }
    }

    private var countryList: some View {
        List(viewModel.countries) { country in
            Text(country.name)
        }
    }
}

#Preview {
    WorldList(viewModel: WorldListViewModel(apiClient: CountriesPreviewApiClient()))
}
