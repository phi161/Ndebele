//
//  FloatingPoint+Utilities.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation

/**
 Helps with String conversion
 Taken from http://stackoverflow.com/a/27705739/289501
 This method will round the result, e.g.:
 1.2340.digits(3) == 1.234
 1.2345.digits(3) == 1.234
 but
 1.2349.digits(3) == 1.235
 */
extension FloatingPoint {
    func fixedFraction(digits: Int) -> String {
        return String(format: "%.\(digits)f", self as! CVarArg)
    }
}
