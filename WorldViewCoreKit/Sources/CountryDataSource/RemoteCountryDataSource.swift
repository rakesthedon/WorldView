//
//  RemoteCountryDataSource.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import Foundation
import WorldViewCoreKit

public final class RemoteCountryDataSource: CountryDataSource {

    static var url: URL? { URL(string: "https://restcountries.com/v3.1/all") }

    private let decoder: JSONDecoder
    private let urlSession: URLSession

    public init(decoder: JSONDecoder = .init(), urlSession: URLSession = .shared) {
        self.decoder = decoder
        self.urlSession = urlSession
    }

    public func getCountries() async throws -> [Country] {
        guard let url = RemoteCountryDataSource.url else { throw ApiError.invalidConfiguration }

        do {
            let data = try await urlSession.data(from: url).0
            let countries = try decoder.decode([FailableDecodableWrapper<Country>].self, from: data)

            return countries.compactMap { $0.wrappedValue }
        } catch {
            // TODO: Log Error
            throw ApiError.requestFailed(error: error)
        }
    }
}
