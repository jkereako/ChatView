//
//  ConversationTableViewController.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/19/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class ConversationTableViewController: UITableViewController {
    var viewModel: [Conversation]? {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableViewCellReuseIdentifier = "ConversationTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(
            nibName: tableViewCellReuseIdentifier,
            bundle: Bundle(for: ConversationTableViewCell.self)
        )

        tableView.register(nib, forCellReuseIdentifier: tableViewCellReuseIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension ConversationTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel == nil ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as?
                ConversationTableViewCell else {
                    assertionFailure("Expected a ConversationTableViewCell")
                    return UITableViewCell()
            }

            cell.viewModel = viewModel![indexPath.row]

            return cell
    }
}

// MARK: - UITableViewDelegate
extension ConversationTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {

            return 60
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Navigate
        let viewController = ChatViewController()
        viewController.viewModel = MockDataGenerator.messages
        navigationController?.pushViewController(viewController, animated: true)
    }
}
