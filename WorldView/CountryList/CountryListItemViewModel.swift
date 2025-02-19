//
//  CountryListItemViewModel.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit

struct CountryListItemViewModel: Identifiable {
    
    var id: String { country.name }

    var title: String { [country.flag, country.name].compactMap(\.self).joined(separator: " ") }
    var subTitle: String { country.capitals.joined(separator: ", ") }

    private let country: Country

    init?(country: Country?) {
        guard let country else { return nil }

        self.country = country
    }
}
