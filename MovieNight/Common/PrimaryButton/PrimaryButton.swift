//
//  PrimaryButton.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import UIKit

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
}

extension PrimaryButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Theme.Color.brickRedColor : Theme.Color.primaryColor
        }
    }
    func setupUI() {
        self.layer.cornerRadius = 5
        self.backgroundColor = Theme.Color.primaryColor
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = Theme.Font.boldFont(with: 18)
    }
}

