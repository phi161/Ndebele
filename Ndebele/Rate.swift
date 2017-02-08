//
//  Rate.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation

struct FormattedPrice {
    let left: String
    let highlighted: String
    let fractional: String

    var stringRepresentation: String {
        return "\(left)\(highlighted)\(fractional)"
    }
}

struct Rate {
    let currencyId: Int
    let name: String
    let buyPrice: Double
    let sellPrice: Double
    let pipMultiplier: Int

    var spread: String {
        return String(format: "%.4f", (buyPrice - sellPrice) * Double(pipMultiplier))
    }

    var formattedBuyPrice: FormattedPrice {
        return formattedPrice(value: buyPrice)
    }

    var formattedSellPrice: FormattedPrice {
        return formattedPrice(value: sellPrice)
    }

    func formattedPrice(value: Double) -> FormattedPrice {
        // Find the pip location in the decimal part
        let zeros = pipMultiplier.numberOfTrailingZeros()

        // Use NSString since it provides all the charAt related functionality
        // and we don't need String's unicode support
        let string = value.fixedFraction(digits: 5) as NSString // We have 5 decimal digits or less

        guard let integerPart = string.components(separatedBy: ".").first else {
            return FormattedPrice(left: "", highlighted: "", fractional: "")
        }

        let pipPosition = (integerPart as NSString).length + zeros - 1

        if string.length < pipPosition + 3 {
            return FormattedPrice(left: "", highlighted: "", fractional: "")
        }

        let trimmed = string.substring(to: pipPosition + 3) as NSString

        let leftRange = NSRange(location: 0, length: pipPosition)
        let highlightedRange = NSRange(location: pipPosition, length: 2)
        let fractionalPipRange = NSRange(location: pipPosition + 2, length: 1)

        return FormattedPrice(left: trimmed.substring(with: leftRange),
                              highlighted: trimmed.substring(with: highlightedRange),
                              fractional: trimmed.substring(with: fractionalPipRange)
        )
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
