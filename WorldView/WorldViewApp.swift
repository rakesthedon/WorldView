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
            CountryList(viewModel: .init(apiClient: RemoteApiClient(), formatter: PopulationCountFormatter()))
        }
    }
}
