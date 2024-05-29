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

final class CountryDetailsViewModel: ObservableObject {

    var name: String { country.name }
    var capitals: String? { country.capitals.isEmpty ? nil : country.capitals.joined(separator: "\n") }
    var flagUrl: URL { country.flagUrl }
    var population: String? { formatter.string(for: country.population) }
    var continents: String? { country.continents.isEmpty ? nil : country.continents.joined(separator: "\n") }
    var languages: String? { country.languages.isEmpty ? nil : country.languages.joined(separator: "\n") }

    var markerTitle: String { [country.name, country.flag].joined(separator: " ") }
    var coordinates: CLLocationCoordinate2D { .init(latitude: country.coordinates.latitude, longitude: country.coordinates.longitude) }

    @Published private(set) var region: CLCircularRegion?
    @Published private(set) var flag: UIImage?

    private var flagCancellable: AnyCancellable?
    private let country: Country
    private let formatter: PopulationCountFormatter

    init?(country: Country?, formatter: PopulationCountFormatter) {
        guard let country else { return nil }
        self.country = country
        self.formatter = formatter
    }

    func fetchCountryInformations() {
        searchCountryRegion()
        fetchFlag()
    }

    private func searchCountryRegion() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name

        MKLocalSearch(request: request).start { response, error in
            // TODO: If error != nil, Log Error and Return
            guard let region = response?.mapItems.first?.placemark.region as? CLCircularRegion else { return }
            
            self.region = region
        }
    }

    private func fetchFlag() {
        flagCancellable = URLSession
            .shared
            .dataTaskPublisher(for: flagUrl)
            .compactMap { data, _ in return data }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] flag in
                self?.flag = flag
            }
    }
}
