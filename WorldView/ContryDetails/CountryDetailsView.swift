//
//  CountryDetailsView.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import SwiftUI
import WorldViewCoreKit
import MapKit

struct CountryDetailsView: View {

    @ObservedObject var viewModel: CountryDetailsViewModel

    init?(viewModel: CountryDetailsViewModel?) {
        guard let viewModel else { return nil }
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 24) {

                    if let flag = viewModel.flag {
                        Image(uiImage: flag)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .modifier(SectionShapeModifier())
                    }

                    VStack(spacing: 20) {
                        LineItemWithDetail(title: "Population", value: viewModel.population)
                        LineItemWithDetail(title: "Continent", value: viewModel.continents)
                        LineItemWithDetail(title: "Capital", value: viewModel.capitals)
                        LineItemWithDetail(title: "Languages", value: viewModel.languages)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                    .background(Color(uiColor: .systemGroupedBackground))
                    .modifier(SectionShapeModifier())

                    map
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .navigationTitle(viewModel.name)
        .toolbarTitleDisplayMode(.inlineLarge)
        .onAppear {
            viewModel.fetchCountryInformations()
        }
    }

    @ViewBuilder
    private var map: some View {
        if let region = viewModel.region {
            Map(bounds: .init(centerCoordinateBounds: .init(center: region.center, span: .init()))) {
                MapCircle(.init(center: region.center, radius: region.radius))
                    .foregroundStyle(.clear)
                Marker(viewModel.markerTitle, coordinate: region.center)
            }
            .disabled(true)
            .mapControlVisibility(.hidden)
            .frame(height: 300)
            .modifier(SectionShapeModifier())
        }
    }
}

private struct SectionShapeModifier: ViewModifier {

    func body(content: Content) -> some View {
        return content.clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    CountryDetailsView(viewModel: .init(country: PreviewCountries.france, formatter: PopulationCountFormatter()))
}

#Preview {
    CountryDetailsView(viewModel: .init(country: PreviewCountries.canada, formatter: PopulationCountFormatter()))
}

#Preview {
    CountryDetailsView(viewModel: .init(country: PreviewCountries.southAfrica, formatter: PopulationCountFormatter()))
}
