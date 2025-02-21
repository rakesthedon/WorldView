//
//  CountryListViewModel.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import CountryDataSource
import CountryListUseCase
import WorldViewCoreKit
import SwiftUI

@Observable
final class CountryListViewModel: ObservableObject {

    enum NavigationPath: Hashable {
        case detail(country: Country)
    }

    enum LoadingState {
        case loading
        case loaded(countries: [Country])
        case searching(filteredCountries: [Country], countries: [Country])
        case failed(Error)
    }

    private(set) var search: String = ""

    var filteredCountryList: [Country] {
        guard case .loaded(let countries) = loadingState else { return [] }

        let searchTerm = search.trimmingCharacters(in: .whitespacesAndNewlines)
        return searchTerm.isEmpty ?
        countries :
        countries.filter { country in
            country.name.localizedCaseInsensitiveContains(searchTerm) ||
            country.capitals.contains { capital in
                capital.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }

    var navigationStackPaths: [NavigationPath] = []

    private(set) var loadingState: LoadingState = .loading

    private let useCase: any CountryListUseCaseProtocol
    private let formatter: PopulationCountFormatter

    private var loadedCountries : [Country] {
        switch loadingState {
        case .loading, .failed: []
        case .loaded(let countries), .searching(_, let countries): countries
        }
    }

    init(
        countries: [Country] = [],
        useCase: any CountryListUseCaseProtocol,
        formatter: PopulationCountFormatter = .init()
    ) {
        if !countries.isEmpty {
            loadingState = .loaded(countries: countries)
        }

        self.useCase = useCase
        self.formatter = formatter
    }

    func fetchCountries() async {
        await performRequest()
    }

    func viewModel(for country: Country?) -> CountryListItemViewModel? {
        return CountryListItemViewModel(country: country)
    }

    func detailViewModel(for country: Country?) -> CountryDetailsViewModel? {
        return CountryDetailsViewModel(country: country, formatter: formatter)
    }

    func updateSearch(text: String) {
        guard loadedCountries.isEmpty == false else { return }

        let searchTerm = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if searchTerm.isEmpty {
            self.loadingState = .loaded(countries: loadedCountries)
            self.search = searchTerm
            return
        }

        let filteredCountries = loadedCountries.filter { country in
            country.name.localizedCaseInsensitiveContains(searchTerm) ||
            country.capitals.contains { capital in
                capital.localizedCaseInsensitiveContains(searchTerm)
            }
        }

        self.set(filteredCountries: filteredCountries, countries: loadedCountries, searchText: text)
    }

    func didSelect(country: Country) {
        navigationStackPaths.append(.detail(country: country))
    }

    private func performRequest() async {
        await startLoading()
        do {
            let countries = try await useCase.getCountries()
            await set(countries: countries)
        } catch {
            await handle(error: error)
        }
    }



    @MainActor private func startLoading() {
        loadingState = .loading
    }

    @MainActor private func set(countries: [Country]) {
        withAnimation {
            loadingState = .loaded(countries: countries)
        }
    }

    func set(filteredCountries: [Country], countries: [Country], searchText: String) {
        withAnimation {
            self.search = searchText
            loadingState = .searching(filteredCountries: filteredCountries, countries: countries)
        }
    }

    @MainActor private func handle(error: Error) {
        loadingState = .failed(error)
    }
}
