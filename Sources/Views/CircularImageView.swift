//
//  CircularImageView.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()

        assert(frame.width == frame.height, "Expected width and height to be equal.")

        isOpaque = true
        clipsToBounds = true

        // These 2 lines pixel-align the image
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
