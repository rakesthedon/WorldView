//
//  Created by Yannick Jacques on 2024-05-29.
//

import Foundation

public final class PopulationCountFormatter {

    private let formatter: NumberFormatter

    public init() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        self.formatter = formatter
    }

    public func string(for population: Int) -> String? {
        return formatter.string(from: .init(integerLiteral: population))
    }
}
