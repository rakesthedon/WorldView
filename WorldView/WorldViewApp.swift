//
//  WorldViewApp.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import SwiftUI
import WorldViewCoreKit

@main
struct WorldViewApp: App {
    var body: some Scene {
        WindowGroup {
            CountryDetailsView(viewModel: .init(country: PreviewCountries.france, formatter: PopulationCountFormatter()))
        }
    }
}
