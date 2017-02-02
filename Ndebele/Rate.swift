//
//  Rate.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation
import UIKit

struct Rate {
    let currencyId: Int
    let name: String
    let buyPrice: Double
    let sellPrice: Double
    let pipMultiplier: Int

    var spread: String {
        return String(format: "%.4f", (buyPrice - sellPrice) * Double(pipMultiplier))
    }

    var formattedBuyPrice: NSAttributedString {
        return formattedPrice(value: buyPrice)
    }

    var formattedSellPrice: NSAttributedString {
        return formattedPrice(value: sellPrice)
    }

    func formattedPrice(value: Double) -> NSAttributedString {
        // Find the pip location in the decimal part
        let zeros = pipMultiplier.numberOfTrailingZeros()

        // Use NSString since it provides all the charAt related functionality
        // and we don't need String's unicode support
        let string = String(value) as NSString

        guard let integerPart = string.components(separatedBy: ".").first else {
            return NSAttributedString(string: "")
        }

        let pipPosition = (integerPart as NSString).length + zeros - 1

        let trimmed = string.substring(to: pipPosition + 3)

        let leftRange = NSRange(location: 0, length: pipPosition)
        let highlightedRange = NSRange(location: pipPosition, length: 2)
        let fractionalPipRange = NSRange(location: pipPosition + 2, length: 1)

        let mutableAttributedString = NSMutableAttributedString(string: trimmed, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20)])

        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: UIColor.red], range: leftRange)
        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24), NSForegroundColorAttributeName: UIColor.blue], range: highlightedRange)
        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.green], range: fractionalPipRange)

        return mutableAttributedString
    }
}

extension Rate {
    init?(dictionary: [String: Any]) {
        guard let currencyId = dictionary["currencyId"] as? Int,
            let name = dictionary["name"] as? String,
            let buyPrice = dictionary["buy"] as? Double,
            let sellPrice = dictionary["sell"] as? Double,
            let pipMultiplier = dictionary["pipMultiplier"] as? Int
        else {
            return nil
        }

        self.currencyId = currencyId
        self.name = name
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.pipMultiplier = pipMultiplier
    }
}
