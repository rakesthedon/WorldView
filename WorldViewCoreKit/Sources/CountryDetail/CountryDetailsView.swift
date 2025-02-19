//
//  CountryDetailsView.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import SwiftUI
import WorldViewCoreKit
import MapKit

public struct CountryDetailsView: View {

    @State var viewModel: CountryDetailsViewModel

    public init?(viewModel: CountryDetailsViewModel?) {
        guard let viewModel else { return nil }
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                flag
                countryInfo
                map
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(viewModel.name)
        .toolbarTitleDisplayMode(.inlineLarge)
        .onAppear {
            viewModel.fetchCountryInformations()
        }
    }

    private var countryInfo: some View {
        VStack(spacing: 20) {
            LineItemWithDetail(title: "Population", value: viewModel.formattedPopulation)
            LineItemWithDetail(title: "Continent", value: viewModel.continents)
            LineItemWithDetail(title: "Capital", value: viewModel.capitals)
            LineItemWithDetail(title: "Languages", value: viewModel.languages)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
        .background(.background.secondary)
        .modifier(SectionShapeModifier())
    }

    @ViewBuilder
    private var flag: some View {
        if let flag = viewModel.flag {
            Image(uiImage: flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .modifier(SectionShapeModifier())
        }
    }

    @ViewBuilder
    private var map: some View {
        if let placemark = viewModel.placemark, let region = viewModel.region {
            Map(bounds: .init(
                centerCoordinateBounds: .init(center: placemark.coordinate, span: .init()))) {
                    MapCircle(
                        .init(
                            center: placemark.coordinate,
                            radius: region.radius))
                    .foregroundStyle(.clear)
                    Marker(viewModel.markerTitle, coordinate: placemark.coordinate)
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
//
//#Preview {
//    CountryDetailsView(viewModel: .init(country: PreviewCountries.france, formatter: PopulationCountFormatter()))
//}
//
//#Preview {
//    CountryDetailsView(viewModel: .init(country: PreviewCountries.canada, formatter: PopulationCountFormatter()))
//}
//
//#Preview {
//    CountryDetailsView(viewModel: .init(country: PreviewCountries.southAfrica, formatter: PopulationCountFormatter()))
//}
