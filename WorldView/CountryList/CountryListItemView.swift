//
//  CountryListItemView.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import SwiftUI

struct CountryListItemView: View {

    let viewModel: CountryListItemViewModel

    init?(viewModel: CountryListItemViewModel?) {
        guard let viewModel else { return nil }
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.title)
                .bold()
            Text(viewModel.subTitle)
                .lineLimit(1)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CountryListItemView(viewModel: .init(country: PreviewCountries.france))
}

#Preview {
    CountryListItemView(viewModel: .init(country: PreviewCountries.southAfrica))
}

#Preview {
    CountryListItemView(viewModel: .init(country: PreviewCountries.southAfrica))
}
