//
//  ConversationTableViewCell.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/19/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class ConversationTableViewCell: UITableViewCell {
    var viewModel: Conversation! {
        didSet {
            lastMessage.text = viewModel.lastMessage.content
            name.text = viewModel.user.name

        }
    }
    @IBOutlet private weak var avatar: CircularImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var lastMessage: UILabel!
    @IBOutlet private weak var timeOfLastMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        name.text = nil
        lastMessage.text = nil
        timeOfLastMessage.text = nil

        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.purple.cgColor
    }
}
