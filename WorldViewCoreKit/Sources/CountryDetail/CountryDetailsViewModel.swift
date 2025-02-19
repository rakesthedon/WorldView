//
//  CountryDetailsViewModel.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import UIKit
import CoreLocation
import WorldViewCoreKit
import Combine
import MapKit
import SwiftUI

@Observable
public final class CountryDetailsViewModel {

    struct State {
        var region: CLCircularRegion?
        var placemark: MKPlacemark?
        var flag: UIImage?

        mutating
        func update<Value>(_ keyPath: WritableKeyPath<State, Value>, _ value: Value) {
            self[keyPath: keyPath] = value
        }
    }

    let name: String
    let capitals: String?
    let flagUrl: URL
    let population: Int
    let continents: String?
    let languages: String?

    let markerTitle: String
    let coordinates: CLLocationCoordinate2D

    var formattedPopulation: String { formatter.string(for: population) ?? "\(population)" }
    var region: CLCircularRegion? { state.region }
    var placemark: MKPlacemark? { state.placemark }
    var flag: UIImage? { state.flag }

    private(set) var state: State = .init()

    private var flagCancellable: AnyCancellable?
    private let formatter: PopulationCountFormatter

    public init(
        name: String,
        capitals: String?,
        flagUrl: URL,
        population: Int,
        continents: String?,
        languages: String?,
        markerTitle: String,
        coordinates: CLLocationCoordinate2D,
        flag: UIImage? = nil,
        flagCancellable: AnyCancellable? = nil,
        formatter: PopulationCountFormatter
    ) {
        self.name = name
        self.capitals = capitals
        self.flagUrl = flagUrl
        self.population = population
        self.continents = continents
        self.languages = languages
        self.markerTitle = markerTitle
        self.coordinates = coordinates
        self.flagCancellable = flagCancellable
        self.formatter = formatter
    }

    public convenience init?(country: Country?, formatter: PopulationCountFormatter) {
        guard let country else { return nil }

        self.init(
            name: country.name,
            capitals: country.capitals.isEmpty ? nil : country.capitals.joined(separator: "\n"),
            flagUrl: country.flagUrl,
            population: country.population,
            continents: country.continents.isEmpty ? nil : country.continents.joined(separator: "\n"),
            languages: country.languages.isEmpty ? nil : country.languages.joined(separator: "\n"),
            markerTitle: [country.name, country.flag].compactMap(\.self).joined(separator: " "),
            coordinates: .init(latitude: country.coordinates.latitude, longitude: country.coordinates.longitude),
            formatter: formatter
        )
    }

    func fetchCountryInformations() {
        Task { [weak self] in
            try? await self?.fetchFlag()
            try? await self?.searchCountryRegion()
        }
    }
}

private extension CountryDetailsViewModel {

    func searchCountryRegion() async throws {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name

        let search = MKLocalSearch(request: request)

        let response = try await search.start()

        guard
            let placemark = response.mapItems.first?.placemark,
            let region = placemark.region as? CLCircularRegion
        else {
            NSLog("Failed to fetch coordinates")
            return
        }

        await self.update(placemark: placemark, region: region)
    }

    @MainActor
    func update(placemark: MKPlacemark, region: CLCircularRegion) {
        var newState = self.state
        newState.update(\.placemark, placemark)
        newState.update(\.region, region)

        self.state = newState
    }

    @MainActor
    func update(flag: UIImage) {
        self.state.update(\.flag, flag)
    }

    func fetchFlag() async throws {
        let data = try await URLSession.shared.data(from: flagUrl).0
        guard let flag = UIImage(data: data) else { return }

        await self.update(flag: flag)
    }
}
