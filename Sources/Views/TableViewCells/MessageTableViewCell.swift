//
//  MessageTableViewCell.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    var viewModel: Message! {
        didSet {
            message.text = viewModel.content
        }
    }

    @IBOutlet weak var message: UITextView!
    @IBOutlet private weak var messageBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        message.text = nil
        messageBackground.image = nil
        selectionStyle = .none

        messageBackground.layer.cornerRadius = 15
        messageBackground.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        message.text = nil
        message.isHidden = false
        messageBackground.image = nil
    }
}
