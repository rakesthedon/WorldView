//
//  LineItemWithDetail.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-29.
//

import SwiftUI

struct LineItemWithDetail: View {
    let title: String
    let value: String

    init?(title: String, value: String?) {
        guard let value, value.isEmpty == false else { return nil }

        self.title = title
        self.value = value
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer(minLength: 64)
            Text(value)
                .bold()
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    VStack {
        LineItemWithDetail(title: "Title", value: "Value")
        LineItemWithDetail(title: "Title", value: "ValueValue")
        LineItemWithDetail(title: "Title", value: "ValueValueValue")
        LineItemWithDetail(title: "Title", value: "ValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValueValue")
    }
}
