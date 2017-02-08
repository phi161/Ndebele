//
//  IntUtilitiesTests.swift
//  Ndebele
//
//  Created by phi on 08/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import XCTest
@testable import Ndebele

class IntUtilitiesTests: XCTestCase {

    // MARK: - Trailing zeros

    func testTrailingZeros() {
        let zeros = 1_000_000.numberOfTrailingZeros()
        XCTAssertEqual(zeros, 6)
    }

    func testTrailingZerosForNegative() {
        let zeros = (-1_000_000).numberOfTrailingZeros()
        XCTAssertEqual(zeros, 0)
    }

    func testTrailingZerosForNoPowerOfTen() {
        let zeros = 42.numberOfTrailingZeros()
        XCTAssertEqual(zeros, 0)
    }

    func testTrailingZerosForZero() {
        let zeros = 0.numberOfTrailingZeros()
        XCTAssertEqual(zeros, 0)
    }

    func testTrailingZerosForOne() {
        let zeros = 1.numberOfTrailingZeros()
        XCTAssertEqual(zeros, 0)
    }
}
