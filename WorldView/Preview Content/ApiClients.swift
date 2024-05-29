//
//  CountriesPreviewApiClient.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit
import WorldViewApiClient

enum PreviewCountries {
    static var canada: Country { .init(name: "Canada", flag: "🇨🇦", capitals: ["Ottawa"], flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
                                       languages: ["English", "French"], coordinates: .init(latitude: 45.42, longitude: -75.7) , borders: ["USA"],
                                       population: 38005238, continents: ["North America"]) }
    static var france: Country { .init(name: "France", flag: "🇫🇷", capitals: ["Paris"], flagUrl: URL(string: "https://flagcdn.com/w320/fr.png")!,
                                       languages: ["French"], coordinates: .init(latitude: 48.86, longitude: 2.35) , borders: ["Spain", "Italy"],
                                       population: 65273511, continents: ["Europe"]) }
    static var southAfrica: Country { .init(name: "South Africa", flag: "🇿🇦", capitals: ["Pretoria", "Bloemfontein", "Cape Town"],
                                            flagUrl: URL(string: "https://flagcdn.com/w320/za.png")!, languages: ["Afrikaans", "English", "Zulu"],
                                            coordinates: .init(latitude: -25.74, longitude: 28.19) , borders: ["Namibia", "Botswana"],
                                            population: 59308690, continents: ["Africa"]) }
}

final class CountriesPreviewApiClient: ApiClient {

    static var defaultCountries: [Country] {
        [
            PreviewCountries.canada,
            PreviewCountries.france,
            PreviewCountries.southAfrica
        ]
    }

    let countries: [Country]

    private let delay: TimeInterval

    init(countries: [Country] = CountriesPreviewApiClient.defaultCountries, delay: TimeInterval = 0) {
        self.countries = countries
        self.delay = delay
    }

    func fetchCountries() async throws -> [Country] {
        try? await Task.sleep(for: .seconds(delay))
        return countries
    }
}

final class ForcedFailureApiClient: ApiClient {

    let error: ApiError

    init(error: ApiError) {
        self.error = error
    }

    func fetchCountries() async throws -> [Country] {
        throw error
    }
}
