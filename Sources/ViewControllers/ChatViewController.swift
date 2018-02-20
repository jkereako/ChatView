//
//  ChatTableViewController.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class ChatViewController: UIViewController {
    var viewModel: [Message]?

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textInput: UIView!

    private let RecipientTableViewCellReuseIdentifier = "RecipientTableViewCell"
    private let SenderTableViewCellReuseIdentifier = "SenderTableViewCell"

    init() {
        super.init(nibName: "ChatView", bundle: Bundle(for: ChatViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel![indexPath.row]

        switch message.owner {
        case .sender:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SenderTableViewCellReuseIdentifier,
                for: indexPath) as? SenderTableViewCell else {
                    assertionFailure("Expected a SenderTableViewCell")

                    return UITableViewCell()
            }

            cell.viewModel = message
            return cell
        case .recipient:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipientTableViewCellReuseIdentifier,
                for: indexPath) as? RecipientTableViewCell else {
                    assertionFailure("Expected a RecipientTableViewCell")

                    return UITableViewCell()
            }

            cell.viewModel = message
            return cell
        }
    }
}

extension ChatViewController: UITableViewDelegate {

}

private extension ChatViewController {
    func registerNibs() {
        let senderNib = UINib(
            nibName: SenderTableViewCellReuseIdentifier,
            bundle: Bundle(for: SenderTableViewCell.self)
        )

        let recipientNib = UINib(
            nibName: RecipientTableViewCellReuseIdentifier,
            bundle: Bundle(for: RecipientTableViewCell.self)
        )

        tableView.register(
            recipientNib, forCellReuseIdentifier: RecipientTableViewCellReuseIdentifier
        )
        tableView.register(senderNib, forCellReuseIdentifier: SenderTableViewCellReuseIdentifier)
    }
}
