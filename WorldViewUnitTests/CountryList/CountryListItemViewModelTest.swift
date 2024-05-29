//
//  CountryListItemViewModelTest.swift
//  WorldViewUnitTests
//
//  Created by Yannick Jacques on 2024-05-28.
//

import XCTest
import WorldViewCoreKit
@testable import WorldView

final class CountryListItemViewModelTest: XCTestCase {

    func testWhenViewModelInitialization() {
        let viewModel = CountryListItemViewModel(country: PreviewCountries.southAfrica)
        let nilViewModel = CountryListItemViewModel(country: nil)

        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel?.title, "🇿🇦 South Africa")
        XCTAssertEqual(viewModel?.subTitle, "Pretoria, Bloemfontein, Cape Town")
        XCTAssertNil(nilViewModel)
    }
}
