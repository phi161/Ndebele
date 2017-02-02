//
//  Int+Utilities.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation

extension Int {

    /**
     Calculates the number of trailing "0"s for an Int that is a power of 10
     If the number is not a power of 10, it returns 0
     */
    func numberOfTrailingZeros() -> Int {
        var myself = self
        while myself > 9 && myself % 10 == 0 {
            myself /= 10
        }

        if myself == 1 {
            return Int(log10(Double(self)))
        }
        return 0
    }
}
