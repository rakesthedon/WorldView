//
//  RemoteApiClient.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import Foundation
import WorldViewCoreKit
import WorldViewApiClient

final class RemoteApiClient: ApiClient {

    static var url: URL? { URL(string: "https://restcountries.com/v3.1/all") }

    private let decoder = JSONDecoder()

    func fetchCountries() async throws -> [Country] {
        guard let url = RemoteApiClient.url else { throw ApiError.invalidConfiguration }

        do {
            let data = try await URLSession.shared.data(from: url).0
            let countries = try decoder.decode([FailableDecodableWrapper<Country>].self, from: data)

            return countries.compactMap { $0.wrappedValue }
        } catch {
            // TODO: Log Error
            throw ApiError.requestFailed(error: error)
        }
    }
}
