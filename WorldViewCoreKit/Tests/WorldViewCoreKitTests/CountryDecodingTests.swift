import XCTest
@testable import WorldViewCoreKit

final class CountryDecodingTests: XCTestCase {

    func testDecodingValidCountryJsonReturnCorrectCountry() throws {
        let decoder = JSONDecoder()
        let expectedContry = Country(
            name: "Canada",
            flag: "🇨🇦",
            capitals: ["Ottawa"],
            flagUrl: URL(string: "https://flagcdn.com/w320/ca.png")!,
            languages: [
                "English",
                "French"
            ],
            coordinates: Country.Coordinates(latitude: 60.0, longitude: -95.0),
            borders: ["USA"],
            population: 38005238,
            continents: ["North America"]
        )

        let country = try decoder.decode(Country.self, from: Constants.canadaJson.data(using: .utf8)!)

        XCTAssertEqual(country, expectedContry)
    }

    func testDecodingEmptyJsonThrowsAnError() {
        let decoder = JSONDecoder()

        let emptyJsonData = "{}".data(using: .utf8)!

        XCTAssertThrowsError(try decoder.decode(Country.self, from: emptyJsonData))
    }

    func testDecodingJsonWithMissingFieldThrowAnError() throws {
        let decoder = JSONDecoder()
        let removedFields: [String] = [
            "\"common\": \"Canada\",\n",
            "\"flag\": \"🇨🇦\",\n",
            "\"capital\": [\"Ottawa\"],\n",
            "\"latlng\": [60.0, -95.0],\n",
            "\"png\": \"https://flagcdn.com/w320/ca.png\",\n",
            "\"languages\": { \"eng\": \"English\", \"fra\": \"French\" },\n",
            "\"borders\": [\"USA\"],\n"
        ]

        try removedFields.forEach { field in
            let data = Constants.canadaJson.replacingOccurrences(of: field, with: "").data(using: .utf8)!
            XCTAssertThrowsError(try decoder.decode(Country.self, from: data))
        }
    }

    func testDecodingCountryListJsonWithSomeInvalidCountriesShouldNotThrowAnyError() throws {
        let decoder = JSONDecoder()
        let data = Mocks.contriesWithMissingValues.data(using: .utf8)!

        var result = try decoder.decode([FailableDecodableWrapper<Country>].self, from: data)
        var decodedItems = result.compactMap { $0.wrappedValue }

        XCTAssertEqual(result.count, 8)
        XCTAssertLessThan(decodedItems.count, result.count)
    }
}

private extension CountryDecodingTests {

    enum Constants {
        static var canadaJson: String {
        """
        {
        "name": {
            "common": "Canada",
            "official": "Canada",
            "nativeName": {
                "eng": {
                    "official": "Canada",
                    "common": "Canada"
                },
                "fra": {
                    "official": "Canada",
                    "common": "Canada"
                }
            }
        },
        "tld": [
            ".ca"
        ],
        "cca2": "CA",
        "ccn3": "124",
        "cca3": "CAN",
        "cioc": "CAN",
        "independent": true,
        "status": "officially-assigned",
        "unMember": true,
        "currencies": {
            "CAD": {
                "name": "Canadian dollar",
                "symbol": "$"
            }
        },
        "idd": {
            "root": "+1",
            "suffixes": [
                ""
            ]
        },
        "capital": ["Ottawa"],
        "altSpellings": [
            "CA"
        ],
        "region": "Americas",
        "subregion": "North America",
        "languages": { "eng": "English", "fra": "French" },
        "translations": {
            "ara": {
                "official": "كندا",
                "common": "كندا"
            },
            "bre": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "ces": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "cym": {
                "official": "Canada",
                "common": "Canada"
            },
            "deu": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "est": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "fin": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "fra": {
                "official": "Canada",
                "common": "Canada"
            },
            "hrv": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "hun": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "ita": {
                "official": "Canada",
                "common": "Canada"
            },
            "jpn": {
                "official": "カナダ",
                "common": "カナダ"
            },
            "kor": {
                "official": "캐나다",
                "common": "캐나다"
            },
            "nld": {
                "official": "Canada",
                "common": "Canada"
            },
            "per": {
                "official": "کانادا",
                "common": "کانادا"
            },
            "pol": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "por": {
                "official": "Canadá",
                "common": "Canadá"
            },
            "rus": {
                "official": "Канада",
                "common": "Канада"
            },
            "slk": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "spa": {
                "official": "Canadá",
                "common": "Canadá"
            },
            "srp": {
                "official": "Канада",
                "common": "Канада"
            },
            "swe": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "tur": {
                "official": "Kanada",
                "common": "Kanada"
            },
            "urd": {
                "official": "کینیڈا",
                "common": "کینیڈا"
            },
            "zho": {
                "official": "加拿大",
                "common": "加拿大"
            }
        },
        "latlng": [60.0, -95.0],
        "landlocked": false,
        "borders": ["USA"],
        "area": 9984670.0,
        "demonyms": {
            "eng": {
                "f": "Canadian",
                "m": "Canadian"
            },
            "fra": {
                "f": "Canadienne",
                "m": "Canadien"
            }
        },
        "flag": "🇨🇦",
        "maps": {
            "googleMaps": "https://goo.gl/maps/jmEVLugreeqiZXxbA",
            "openStreetMaps": "https://www.openstreetmap.org/relation/1428125"
        },
        "population": 38005238,
        "gini": {
            "2017": 33.3
        },
        "fifa": "CAN",
        "car": {
            "signs": [
                "CDN"
            ],
            "side": "right"
        },
        "timezones": [
            "UTC-08:00",
            "UTC-07:00",
            "UTC-06:00",
            "UTC-05:00",
            "UTC-04:00",
            "UTC-03:30"
        ],
        "continents": [
            "North America"
        ],
        "flags": {
            "png": "https://flagcdn.com/w320/ca.png",
            "svg": "https://flagcdn.com/ca.svg",
            "alt": "The flag of Canada is composed of a red vertical band on the hoist and fly sides and a central white square that is twice the width of the vertical bands. A large eleven-pointed red maple leaf is centered in the white square."
        },
        "coatOfArms": {
            "png": "https://mainfacts.com/media/images/coats_of_arms/ca.png",
            "svg": "https://mainfacts.com/media/images/coats_of_arms/ca.svg"
        },
        "startOfWeek": "sunday",
        "capitalInfo": {
            "latlng": [
                45.42,
                -75.7
            ]
        },
        "postalCode": {
            "format": "@#@ #@#",
            "regex": "^([ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJKLMNPRSTVWXYZ]) ?(\\d[ABCEGHJKLMNPRSTVWXYZ]\\d)$"
        }
        }
        """
        }
    }
}
