//
//  RoundedRectangularView.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/24/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundedRectangularView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        isOpaque = true
        clipsToBounds = true
        layer.cornerRadius = 15
    }
}
