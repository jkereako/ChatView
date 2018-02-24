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

    @IBOutlet weak var message: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        message.text = nil
    }
}
