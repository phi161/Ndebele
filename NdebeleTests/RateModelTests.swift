//
//  RateModelTests.swift
//  Ndebele
//
//  Created by phi on 08/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import XCTest
@testable import Ndebele

class RateModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Initializer

    /*
     JSON values
     currencyId: Number (Int)
     name: String (String)
     buy: Number (Double)
     sell: Number (Double)
     pipMultiplier: Number (Int)
     */

    func testInit() {
        let testDictionary = [
            "currencyId": 42,
            "name": "TEST",
            "buy": 4.2,
            "sell": 4.1,
            "pipMultiplier": 100,
        ] as [String: Any]

        let rate = Rate(dictionary: testDictionary)
        XCTAssertNotNil(rate)
    }

    func testFailableInit() {
        let testDictionary = [
            "currencyId": "NOT A NUMBER!",
            "name": "TEST",
            "buy": 4.2,
            "sell": 4.1,
            "pipMultiplier": 100,
        ] as [String: Any]

        let rate = Rate(dictionary: testDictionary)
        XCTAssertNil(rate)
    }

    func testInitValues() {
        let testDictionary = [
            "currencyId": 42,
            "name": "TEST",
            "buy": 4.2,
            "sell": 4.1,
            "pipMultiplier": 100,
        ] as [String: Any]

        let rate = Rate(dictionary: testDictionary)
        XCTAssertTrue(
            rate?.currencyId == 42 &&
                rate?.name == "TEST" &&
                rate?.buyPrice == 4.2 &&
                rate?.sellPrice == 4.1 &&
                rate?.pipMultiplier == 100
        )
    }

    // MARK: - Spread

    // spread = (buy-sell)*pipMultiplier
    func testSpreadCalculation() {
        let rate = Rate(currencyId: 0, name: "TEST", buyPrice: 0.3, sellPrice: 0.2, pipMultiplier: 1000)

        XCTAssertEqual(rate.spread, String(format: "%.4f", 100.0))
    }

    func testZeroSpreadCalculation() {
        let rate = Rate(currencyId: 0, name: "TEST", buyPrice: 42.0, sellPrice: 42.0, pipMultiplier: 1000)

        XCTAssertEqual(rate.spread, String(format: "%.4f", 0.0))
    }

    func testZeroPipSpreadCalculation() {
        let rate = Rate(currencyId: 0, name: "TEST", buyPrice: 42.0, sellPrice: 2.0, pipMultiplier: 0)

        XCTAssertEqual(rate.spread, String(format: "%.4f", 0.0))
    }
}
