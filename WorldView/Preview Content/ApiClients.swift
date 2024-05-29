//
//  CountriesPreviewApiClient.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit
import WorldViewApiClient

final class CountriesPreviewApiClient: ApiClient {

    func fetchCountries() async throws -> [Country] {
        return [
            .init(name: "Canada", flag: "🇨🇦", capitals: ["Ottawa"], flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
                  languages: ["English", "French"], coordinates: .init(latitude: 45.42, longitude: -75.7) , borders: ["USA"],
                  population: 38005238, continents: ["North America"]),
            .init(name: "Canada 1", flag: "🇨🇦", capitals: ["Ottawa"], flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
                  languages: ["English", "French"], coordinates: .init(latitude: 45.42, longitude: -75.7) , borders: ["USA"],
                  population: 38005238, continents: ["North America"]),
            .init(name: "Canada 2", flag: "🇨🇦", capitals: ["Ottawa"], flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
                  languages: ["English", "French"], coordinates: .init(latitude: 45.42, longitude: -75.7) , borders: ["USA"],
                  population: 38005238, continents: ["North America"]),
            .init(name: "Canada 3", flag: "🇨🇦", capitals: ["Ottawa"], flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
                  languages: ["English", "French"], coordinates: .init(latitude: 45.42, longitude: -75.7) , borders: ["USA"],
                  population: 38005238, continents: ["North America"])
        ]
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
