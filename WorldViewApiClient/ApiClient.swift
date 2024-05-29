//
//  ApiClient.swift
//  WorldViewApiClient
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit

public protocol ApiClient: AnyObject {
    func fetchCountries() async throws -> [Country]
}

public enum ApiError: Error, Equatable {

    case decodingFailed
    case requestFailed(error: Error)

    public static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        return switch(lhs, rhs) {
        case (.decodingFailed, .decodingFailed): true
        case let(.requestFailed(lhsError), .requestFailed(rhsError)): lhsError.localizedDescription == rhsError.localizedDescription
        default: false
        }
    }
}
