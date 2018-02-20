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

    static var messages: [Message] {
        return [
            Message(
                owner: .sender,
                content: "Baby, when I met you there was peace unknown. I set you to find you " +
                         "with a fine-toothed comb",
                isRead: true
            ),
            Message(
                owner: .sender,
                content: "I was soft inside, there was something going on.",
                isRead: true
            ),
            Message(
                owner: .recipient,
                content: "You do something to me that I can't explain. Hold me closer and I feel " +
                         "pain. Every beat of my heart, we've got something going on.",
                isRead: true
            ),
            Message(
                owner: .recipient,
                content: "Tender love is blind, it requires a dedication. Honest love we feel, " +
                         "need no conversation.",
                isRead: true
            ),
            Message(
                owner: .sender,
                content: "And we ride it together, uh-huh. Makin' love with each other, uh-huh ",
                isRead: true
            ),
            Message(
                owner: .sender,
                content: "Islands in the stream, that is what we are",
                isRead: true
            ),
            Message(
                owner: .recipient,
                content: "No one in between, how could we be wrong?",
                isRead: true
            ),
            Message(
                owner: .sender,
                content: "Sail away with me, to another world. And we can rely on each other" +
                         "uh-huh. From one lover to another, uh-huh.",
                isRead: true
            )
        ]
    }
}
