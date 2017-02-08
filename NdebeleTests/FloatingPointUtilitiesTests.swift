//
//  FloatingPointUtilitiesTests.swift
//  Ndebele
//
//  Created by phi on 08/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import XCTest
@testable import Ndebele

class FloatingPointUtilitiesTests: XCTestCase {

    func testFixedFraction() {
        XCTAssertTrue(
            1.2340.fixedFraction(digits: 3) == "1.234" &&
                1.2345.fixedFraction(digits: 3) == "1.234" &&
                1.2349.fixedFraction(digits: 3) == "1.235"
        )
    }

    func testFixedFractionMoreDigits() {
        XCTAssertEqual(1.2345.fixedFraction(digits: 7), "1.2345000")
    }

    func testFixedFractionZeroDigits() {
        XCTAssertEqual(1.2345.fixedFraction(digits: 0), "1")
    }
}
