//
//  RateView.swift
//  Ndebele
//
//  Created by phi on 08/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation
import UIKit

class RateView: UIView, NibOwnerLoadable {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var roundedView: UIView!

    // MARK: - Setup

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        RateView.loadFromNib(owner: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 5.0
    }

    // MARK: - GUI Update

    func update(value: NSAttributedString, color: UIColor) {
        label.attributedText = value
        UIView.animate(withDuration: 0.2) {
            self.roundedView.backgroundColor = color
        }
    }
}
