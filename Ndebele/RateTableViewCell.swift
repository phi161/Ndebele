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
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    @IBOutlet var spreadLabel: UILabel!
}

extension RateTableViewCell {
    func populate(name: String, buyPrice: Double, sellPrice: Double, spread: String) {
        nameLabel.text = name
        buyLabel.text = String(buyPrice)
        sellLabel.text = String(sellPrice)
        spreadLabel.text = spread
    }

    func populate(rate: Rate) {
        nameLabel.text = rate.name
        buyLabel.attributedText = rate.formattedBuyPrice
        sellLabel.attributedText = rate.formattedSellPrice
        spreadLabel.text = rate.spread
    }
}
