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

    func update(value: NSAttributedString, state: HistoryState) {
        label.attributedText = value
        let color: UIColor
        switch state {
        case .increased:
            color = UIColor.green
        case .decreased:
            color = UIColor.red
        case .unaffected:
            color = UIColor.lightGray
        }

        UIView.animate(withDuration: 0.2) {
            self.roundedView.backgroundColor = color
        }
    }
}
