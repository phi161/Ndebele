//
//  RateView.swift
//  Ndebele
//
//  Created by phi on 08/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation
import UIKit

enum HistoryState {
    case increased
    case decreased
    case unaffected
}

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
        roundedView.backgroundColor = UIColor.lightGray
        roundedView.layer.cornerRadius = 5.0
    }

    // MARK: - GUI Update

    func update(formattedPrice: FormattedPrice, state: HistoryState) {

        let mutableAttributedString = NSMutableAttributedString(string: formattedPrice.stringRepresentation, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20)])

        let leftLength = formattedPrice.left.characters.count
        let highlightedLength = formattedPrice.highlighted.characters.count
        let fractonalPipLength = formattedPrice.fractional.characters.count

        let leftRange = NSRange(location: 0, length: leftLength)
        let highlightedRange = NSRange(location: leftLength, length: highlightedLength)
        let fractionalPipRange = NSRange(location: leftLength + highlightedLength, length: fractonalPipLength)

        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 22), NSForegroundColorAttributeName: UIColor.darkGray], range: leftRange)
        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 26), NSForegroundColorAttributeName: UIColor.black], range: highlightedRange)
        mutableAttributedString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.gray], range: fractionalPipRange)

        label.attributedText = mutableAttributedString

        let color: UIColor
        switch state {
        case .increased:
            color = UIColor.green
        case .decreased:
            color = UIColor.red
        case .unaffected:
            color = UIColor.lightGray
        }

        self.roundedView.backgroundColor = color
    }
}
