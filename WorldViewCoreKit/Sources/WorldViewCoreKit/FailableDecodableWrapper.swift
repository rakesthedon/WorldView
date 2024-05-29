//
//  File.swift
//  
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation

public struct FailableDecodableWrapper<DecodableType>: Decodable where DecodableType: Decodable {

    public let wrappedValue: DecodableType?

    public init(wrappedValue: DecodableType?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        do {
            self.wrappedValue = try container.decode(DecodableType.self)
        } catch {
            self.wrappedValue = nil
            // We could log an error here
        }
    }
}
