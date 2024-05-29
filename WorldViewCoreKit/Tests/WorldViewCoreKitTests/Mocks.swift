//
//  File.swift
//  
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation

enum Mocks {
    static var contriesWithMissingValues: String {
        """
        [
            {
                "name": {
                    "common": "Moldova",
                    "official": "Republic of Moldova",
                    "nativeName": {
                        "ron": {
                            "official": "Republica Moldova",
                            "common": "Moldova"
                        }
                    }
                },
                "capital": [
                    "Chișinău"
                ],
                "region": "Europe",
                "subregion": "Eastern Europe",
                "languages": {
                    "ron": "Romanian"
                },
                "latlng": [
                    47.0,
                    29.0
                ],
                "flag": "🇲🇩",
                "population": 2617820,
                "fifa": "MDA",
                "car": {
                    "signs": [
                        "MD"
                    ],
                    "side": "right"
                },
                "timezones": [
                    "UTC+02:00"
                ],
                "continents": [
                    "Europe"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/md.png",
                    "svg": "https://flagcdn.com/md.svg",
                    "alt": "The flag of Moldova is composed of three equal vertical bands of blue, yellow and red, with the national coat of arms centered in the yellow band."
                }
            },
            {
                "name": {
                    "common": "United States",
                    "official": "United States of America",
                    "nativeName": {
                        "eng": {
                            "official": "United States of America",
                            "common": "United States"
                        }
                    }
                },
                "tld": [
                    ".us"
                ],
                "cca2": "US",
                "ccn3": "840",
                "cca3": "USA",
                "cioc": "USA",
                "independent": true,
                "status": "officially-assigned",
                "unMember": true,
                "currencies": {
                    "USD": {
                        "name": "United States dollar",
                        "symbol": "$"
                    }
                },
                "capital": [
                    "Washington, D.C."
                ],
                "languages": {
                    "eng": "English"
                },
                "latlng": [
                    38.0,
                    -97.0
                ],
                "landlocked": false,
                "borders": [
                    "CAN",
                    "MEX"
                ],
                "flag": "🇺🇸",
                "population": 329484123,
                "continents": [
                    "North America"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/us.png",
                    "svg": "https://flagcdn.com/us.svg",
                    "alt": "The flag of the United States of America is composed of thirteen equal horizontal bands of red alternating with white. A blue rectangle, bearing fifty small five-pointed white stars arranged in nine rows where rows of six stars alternate with rows of five stars, is superimposed in the canton."
                }
            },
            {
                "name": {
                    "official": "Department of Mayotte",
                    "nativeName": {
                        "fra": {
                            "official": "Département de Mayotte",
                            "common": "Mayotte"
                        }
                    }
                },
                "tld": [
                    ".yt"
                ],
                "cca2": "YT",
                "ccn3": "175",
                "cca3": "MYT",
                "independent": false,
                "status": "officially-assigned",
                "unMember": false,
                "currencies": {
                    "EUR": {
                        "name": "Euro",
                        "symbol": "€"
                    }
                },
                "idd": {
                    "root": "+2",
                    "suffixes": [
                        "62"
                    ]
                },
                "capital": [
                    "Mamoudzou"
                ],
                "altSpellings": [
                    "YT",
                    "Department of Mayotte",
                    "Département de Mayotte"
                ],
                "region": "Africa",
                "subregion": "Eastern Africa",
                "languages": {
                    "fra": "French"
                },
                "latlng": [
                    -12.83333333,
                    45.16666666
                ],
                "flag": "🇾🇹",
                "population": 226915,
                "continents": [
                    "Africa"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/yt.png",
                    "svg": "https://flagcdn.com/yt.svg"
                }
            },
            {
                "name": {
                    "common": "Nauru",
                    "official": "Republic of Nauru",
                    "nativeName": {
                        "eng": {
                            "official": "Republic of Nauru",
                            "common": "Nauru"
                        },
                        "nau": {
                            "official": "Republic of Nauru",
                            "common": "Nauru"
                        }
                    }
                },
                "capital": [
                    "Yaren"
                ],
                "languages": {
                    "eng": "English",
                    "nau": "Nauru"
                },
                "latlng": [
                    -0.53333333,
                    166.91666666
                ],
                "flag": "🇳🇷",
                "population": 10834,
                "continents": [
                    "Oceania"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/nr.png",
                    "svg": "https://flagcdn.com/nr.svg",
                    "alt": "The flag of Nauru has a dark blue field with a thin yellow horizontal band across the center and a large white twelve-pointed star beneath the horizontal band on the hoist side of the field."
                }
            },
            {
                "name": {
                    "common": "Mozambique",
                    "official": "Republic of Mozambique",
                    "nativeName": {
                        "por": {
                            "official": "República de Moçambique",
                            "common": "Moçambique"
                        }
                    }
                },
                "capital": [
                    "Maputo"
                ],
                "altSpellings": [
                    "MZ",
                    "Republic of Mozambique",
                    "República de Moçambique"
                ],
                "region": "Africa",
                "subregion": "Eastern Africa",
                "languages": {
                    "por": "Portuguese"
                },
                "latlng": [
                    -18.25,
                    35.0
                ],
                "landlocked": false,
                "flag": "🇲🇿",
                "population": 31255435,
                "flags": {
                    "png": "https://flagcdn.com/w320/mz.png",
                    "svg": "https://flagcdn.com/mz.svg",
                    "alt": "The flag of Mozambique is composed of three equal horizontal bands of teal, black with white top and bottom edges, and yellow. A red isosceles triangle spanning about two-fifth the width of the field is superimposed on the hoist side with its base on the hoist end. This triangle bears a crossed rifle and hoe in black superimposed on an open white book which is superimposed on a five-pointed yellow star."
                }
            },
            {
                "name": {
                    "common": "Brazil",
                    "official": "Federative Republic of Brazil",
                    "nativeName": {
                        "por": {
                            "official": "República Federativa do Brasil",
                            "common": "Brasil"
                        }
                    }
                },
                "capital": [
                    "Brasília"
                ],
                "languages": {
                    "por": "Portuguese"
                },
                "latlng": [
                    -10.0,
                    -55.0
                ],
                "flag": "🇧🇷",
                "population": 212559409,
                "continents": [
                    "South America"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/br.png",
                    "svg": "https://flagcdn.com/br.svg",
                    "alt": "The flag of Brazil has a green field with a large yellow rhombus in the center. Within the rhombus is a dark blue globe with twenty-seven small five-pointed white stars depicting a starry sky and a thin white convex horizontal band inscribed with the national motto 'Ordem e Progresso' across its center."
                }
            },
            {
                "name": {
                    "common": "Cape Verde",
                    "official": "Republic of Cabo Verde",
                    "nativeName": {
                        "por": {
                            "official": "República de Cabo Verde",
                            "common": "Cabo Verde"
                        }
                    }
                },
                "capital": [
                    "Praia"
                ],
                "languages": {
                    "por": "Portuguese"
                },
                "latlng": [
                    16.5388,
                    -23.0418
                ],
                "flag": "🇨🇻",
                "population": 555988,
                "continents": [
                    "Africa"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/cv.png",
                    "svg": "https://flagcdn.com/cv.svg",
                    "alt": "The flag of Cape Verde is composed of five horizontal bands of blue, white, red, white and blue in the ratio of 6:1:1:1:3. A ring of ten five-pointed yellow stars is centered at three-eighth of the height from the bottom edge and three-eighth of the width from the hoist end of the field."
                },
                "coatOfArms": {
                    "png": "https://mainfacts.com/media/images/coats_of_arms/cv.png",
                    "svg": "https://mainfacts.com/media/images/coats_of_arms/cv.svg"
                }
            },
            {
                "name": {
                    "common": "Equatorial Guinea",
                    "official": "Republic of Equatorial Guinea",
                    "nativeName": {
                        "fra": {
                            "official": "République de la Guinée Équatoriale",
                            "common": "Guinée équatoriale"
                        },
                        "por": {
                            "official": "República da Guiné Equatorial",
                            "common": "Guiné Equatorial"
                        },
                        "spa": {
                            "official": "República de Guinea Ecuatorial",
                            "common": "Guinea Ecuatorial"
                        }
                    }
                },
                "capital": [
                    "Malabo"
                ],
                "languages": {
                    "fra": "French",
                    "por": "Portuguese",
                    "spa": "Spanish"
                },
                "latlng": [
                    2.0,
                    10.0
                ],
                "borders": [
                    "CMR",
                    "GAB"
                ],
                "flag": "🇬🇶",
                "population": 1402985,
                "continents": [
                    "Africa"
                ],
                "flags": {
                    "png": "https://flagcdn.com/w320/gq.png",
                    "svg": "https://flagcdn.com/gq.svg",
                    "alt": "The flag of Equatorial Guinea is composed of three equal horizontal bands of green, white and red with the national coat of arms centered in the white band and an isosceles triangle superimposed on the hoist side of the field. The triangle is light blue, has its base on the hoist end and spans about one-fifth the width of the field."
                }
            }
        ]
        """
    }
}
