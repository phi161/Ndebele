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
 */
extension FloatingPoint {
    func fixedFraction(digits: Int) -> String {
        // TODO: Better understand what are the implications of using that
        return String(format: "%.\(digits)f", self as! CVarArg)
    }
}
