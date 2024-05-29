//
//  WordListViewModelTests.swift
//  WorldViewUnitTests
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import XCTest
@testable import WorldView
import WorldViewCoreKit
import WorldViewApiClient

final class WordListViewModelTests: XCTestCase {

    func testWhenApiClientReturnsCountriesThenTheViewModelCountryListIsPopulated() async {
        let viewModel = WorldListViewModel(apiClient: CountriesPreviewApiClient())
        XCTAssertTrue(viewModel.countries.count == 0)

        await viewModel.fetchCountries()

        XCTAssertTrue(viewModel.countries.count > 0)
        XCTAssertFalse(viewModel.loading)
    }

    func testWhenApiClientThrowsAnErrorThenTheViewModelSaveThatError() async {
        let client = ForcedFailureApiClient(error: .decodingFailed)
        let viewModel = WorldListViewModel(apiClient: client)
        XCTAssertNil(viewModel.error)
        
        await viewModel.fetchCountries()

        XCTAssertNotNil(viewModel.error)
        let apiError = viewModel.error as! ApiError
        XCTAssertEqual(apiError, client.error)
        XCTAssertFalse(viewModel.loading)
    }
}
