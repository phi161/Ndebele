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
    // TODO: The following pairs should be a separate UIView subclass
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    @IBOutlet var buyLabelBackground: UIView!
    @IBOutlet var sellLabelBackground: UIView!
    @IBOutlet var spreadLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        buyLabelBackground.backgroundColor = UIColor.lightGray
        sellLabelBackground.backgroundColor = UIColor.lightGray
    }
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

    func populate(rate: Rate, previous previousRate: Rate) {
        populate(rate: rate)

        // Buy background
        if rate.buyPrice > previousRate.buyPrice {
            buyLabelBackground.backgroundColor = UIColor.green
        } else if rate.buyPrice < previousRate.buyPrice {
            buyLabelBackground.backgroundColor = UIColor.red
        } else {
            buyLabelBackground.backgroundColor = UIColor.lightGray
        }

        // Sell background
        if rate.sellPrice > previousRate.sellPrice {
            sellLabelBackground.backgroundColor = UIColor.green
        } else if rate.sellPrice < previousRate.sellPrice {
            sellLabelBackground.backgroundColor = UIColor.red
        } else {
            sellLabelBackground.backgroundColor = UIColor.lightGray
        }
    }
}
