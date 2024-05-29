//
//  Created by Yannick Jacques on 2024-05-29.
//

@testable import WorldViewCoreKit
import XCTest

final class PopulationCountFormatterTests: XCTestCase {

    func testFormating() {
        let formatter = PopulationCountFormatter()
        var cases: [(Int, String)] = [
            (1, "1"),
            (10, "10"),
            (100, "100"),
            (1000, "1,000"),
            (10000, "10,000"),
            (100000, "100,000"),
            (1000000, "1,000,000"),
            (10000000, "10,000,000"),
            (100000000, "100,000,000"),
            (1000000000, "1,000,000,000"),
            (10000000000, "10,000,000,000"),
            (100000000000, "100,000,000,000"),
            (1000000000000, "1,000,000,000,000"),
            (10000000000000, "10,000,000,000,000"),
            (100000000000000, "100,000,000,000,000"),
            (1000000000000000, "1,000,000,000,000,000"),
            (10000000000000000, "10,000,000,000,000,000"),
            (100000000000000000, "100,000,000,000,000,000"),
            (1000000000000000000, "1,000,000,000,000,000,000")
        ]

        cases.forEach { (population, expected) in
            XCTAssertEqual(formatter.string(for: population), expected)
        }
    }
}
