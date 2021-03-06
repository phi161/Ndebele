//
//  RateTableViewCell.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sellRateView: RateView!
    @IBOutlet var buyRateView: RateView!
    @IBOutlet var spreadLabel: UILabel!
}

extension RateTableViewCell {
    func populate(rate: Rate) {
        nameLabel.text = rate.name
        spreadLabel.text = rate.spread

        buyRateView.update(formattedPrice: rate.formattedBuyPrice, state: .unaffected)
        sellRateView.update(formattedPrice: rate.formattedSellPrice, state: .unaffected)
    }

    func populate(rate: Rate, previous previousRate: Rate) {
        nameLabel.text = rate.name
        spreadLabel.text = rate.spread

        // Buy
        if rate.buyPrice > previousRate.buyPrice {
            buyRateView.update(formattedPrice: rate.formattedBuyPrice, state: .increased)
        } else if rate.buyPrice < previousRate.buyPrice {
            buyRateView.update(formattedPrice: rate.formattedBuyPrice, state: .decreased)
        } else {
            buyRateView.update(formattedPrice: rate.formattedBuyPrice, state: .unaffected)
        }

        // Sell
        if rate.sellPrice > previousRate.sellPrice {
            sellRateView.update(formattedPrice: rate.formattedSellPrice, state: .increased)
        } else if rate.sellPrice < previousRate.sellPrice {
            sellRateView.update(formattedPrice: rate.formattedSellPrice, state: .decreased)
        } else {
            sellRateView.update(formattedPrice: rate.formattedSellPrice, state: .unaffected)
        }
    }
}
