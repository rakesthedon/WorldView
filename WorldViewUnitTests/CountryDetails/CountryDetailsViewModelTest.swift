//
//  CountryDetailsViewModelTest.swift
//  WorldViewUnitTests
//
//  Created by Yannick Jacques on 2024-05-29.
//

@testable import WorldView

import WorldViewCoreKit
import XCTest
import Foundation

final class CountryDetailsViewModelTest: XCTestCase {

    func testViewModelInitializationAndValues() {
        let formatter = PopulationCountFormatter()
        let country = PreviewCountries.france
        let viewModel = CountryDetailsViewModel(country: country, formatter: formatter)
        let nilViewModel = CountryDetailsViewModel(country: nil, formatter: formatter)

        XCTAssertNotNil(viewModel)
        XCTAssertNil(nilViewModel)
        XCTAssertEqual(viewModel?.name, country.name)
        XCTAssertEqual(viewModel?.capitals, "Paris")
        XCTAssertEqual(viewModel?.population, "65,273,511")
        XCTAssertEqual(viewModel?.continents, "Europe")
    }
}
