//
//  SenderTableViewCell.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class SenderTableViewCell: MessageTableViewCell {
    @IBOutlet private weak var avatar: CircularImageView!

    override var viewModel: Message! {
        didSet {
            message.text = viewModel.content
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        avatar.image = nil
    }
}
