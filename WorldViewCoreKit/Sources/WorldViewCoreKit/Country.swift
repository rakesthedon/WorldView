//
//  Country.swift
//
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation

public struct Country {

    public let name: String
    public let flag: String
    public let capitals: [String]
    public let flagUrl: URL
    public let languages: [String]
    public let coordinates: Coordinates
    public let borders: [String]
    public let population: Int
    public let continents: [String]

    public init(
        name: String,
        flag: String,
        capitals: [String],
        flagUrl: URL,
        languages: [String],
        coordinates: Coordinates,
        borders: [String],
        population: Int,
        continents: [String]
    ) {
        self.name = name
        self.flag = flag
        self.capitals = capitals
        self.flagUrl = flagUrl
        self.languages = languages
        self.coordinates = coordinates
        self.borders = borders
        self.population = population
        self.continents = continents
    }

    public struct Coordinates {
        public let latitude: Double
        public let longitude: Double

        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}

extension Country: Equatable {

    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name && lhs.flag == rhs.flag && lhs.coordinates == rhs.coordinates && lhs.capitals.elementsEqual(rhs.capitals)
    }
}

extension Country.Coordinates: Equatable {
}

extension Country: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case common
        case capital
        case coordinates = "latlng"
        case borders
        case flag
        case flags
        case png
        case languages
        case population
        case continents
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .common)

        let flagUrlsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .flags)
        self.flagUrl = try flagUrlsContainer.decode(URL.self, forKey: .png)

        self.flag = try container.decode(String.self, forKey: .flag)
        self.capitals = try container.decode([String].self, forKey: .capital)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)

        let languages = try container.decode([String: String].self, forKey: .languages)
        self.languages = languages.map { $0.value }.sorted()

        self.borders = try container.decode([String].self, forKey: .borders)
        self.population = try container.decode(Int.self, forKey: .population)
        self.continents = try container.decode([String].self, forKey: .continents)
    }
}

extension Country.Coordinates: Decodable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([Double].self)

        guard values.count == 2 else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [Country.CodingKeys.coordinates],
                debugDescription: "Expected array of two elements"))
        }

        self.latitude = values[0]
        self.longitude = values[1]
    }
}
