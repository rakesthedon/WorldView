//
//  CountryListUseCase.swift
//  WorldViewCoreKit
//
//  Created by Yannick Jacques on 2025-02-18.
//

import CountryDataSource
import WorldViewCoreKit

public protocol CountryListUseCaseProtocol {

    func getCountries() async throws -> [Country]
}

public final class CountryListUseCase {

    private let dataSource: CountryDataSource

    public init(dataSource: CountryDataSource) {
        self.dataSource = dataSource
    }
}

extension CountryListUseCase: CountryListUseCaseProtocol {

    public func getCountries() async throws -> [Country] {
        try await dataSource.getCountries()
            .sorted(by: { $0.name.localizedCompare($1.name) == .orderedAscending })
    }
}
