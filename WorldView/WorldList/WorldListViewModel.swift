//
//  WorldListViewModel.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit
import WorldViewApiClient

final class WorldListViewModel: ObservableObject {

    @Published private(set) var loading: Bool = false
    @Published private(set) var countries: [Country]
    @Published private(set) var error: Error?

    private let client: any ApiClient

    init(countries: [Country] = [], apiClient: any ApiClient) {
        self.countries = countries
        self.client = apiClient
    }

    func fetchCountries() async {
        await startLoading()
        await performRequest()
        await endLoading()
    }

    func viewModel(for country: Country?) -> CountryListItemViewModel? {
        return CountryListItemViewModel(country: country)
    }

    private func performRequest() async {
        do {
            let countries = try await client.fetchCountries()
            await set(countries: countries)
        } catch {
            await handle(error: error)
        }
    }

    @MainActor private func startLoading() {
        error = nil
        loading = true
    }

    @MainActor private func set(countries: [Country]) {
        self.countries = countries
    }

    @MainActor private func handle(error: Error) {
        self.error = error
        // TODO: Log Error Here
    }

    @MainActor private func endLoading() {
        loading = false
    }
}
