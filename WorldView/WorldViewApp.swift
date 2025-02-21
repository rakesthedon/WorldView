//
//  WorldViewApp.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import CountryDataSource
import CountryListUseCase
import WorldViewCoreKit
import SwiftUI

@main
struct WorldViewApp: App {

    @State var countryListViewModel: CountryListViewModel = CountryListViewModel(useCase: CountryListUseCase(dataSource: RemoteCountryDataSource()), formatter: PopulationCountFormatter())

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $countryListViewModel.navigationStackPaths) {
                CountryList(viewModel: countryListViewModel)
                    .navigationDestination(for: CountryListViewModel.NavigationPath.self) { path in
                        switch path {
                        case .detail(let country):
                            CountryDetailsView(viewModel: countryListViewModel.detailViewModel(for: country))
                        }
                    }
            }
        }
    }
}
