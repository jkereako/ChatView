//
//  SenderTableViewCell.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class SenderTableViewCell: MessageTableViewCell {
    @IBOutlet private weak var profilePic: CircularImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        profilePic.image = nil
    }
}
