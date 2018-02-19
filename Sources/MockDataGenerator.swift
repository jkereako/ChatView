//
//  MockDataGenerator.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/19/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class MockDataGenerator {
    static var conversations: [Conversation] {
        let user = User(name: "Johnny Appleseed", email: "japp@apple.com", avatar: #imageLiteral(resourceName: "Avatar"))
        let message = Message(owner: .recipient, content: "TEST", isRead: true)
        let conversation = Conversation(user: user, lastMessage: message)

        return [conversation, conversation, conversation]
    }
}