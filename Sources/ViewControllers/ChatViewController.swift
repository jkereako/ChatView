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
    @IBOutlet private weak var contentInputContainer: UIView!
    @IBOutlet private weak var contentInputContainerBottomLayoutConstraint: NSLayoutConstraint!

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
        subscribeToNotifications()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Prevent the bottom cell from being hidden underneath the content input view.
        tableView.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: contentInputContainer.frame.height, right: 0
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        unsubscribeFromNotifications()

        // If `self` is no longer in the view controller stack, then the back button was tapped.
        if navigationController?.viewControllers.index(of: self) == nil {
            // Dismiss the keyboard if it's showing
            view.endEditing(true)
        }
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

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Dismiss the keyboard if it's showing
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Notifications
private extension ChatViewController {
    @objc
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                assertionFailure("Expected values.")
                return
        }
        contentInputContainerBottomLayoutConstraint.constant = endFrame.cgRectValue.height
        let bottomIndexPath = IndexPath(row: (viewModel?.count ?? 1) - 1 , section: 0)
        tableView.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        contentInputContainerBottomLayoutConstraint.constant = 0
    }

}

// MARK: - Private helpers
private extension ChatViewController {
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }

    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

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
