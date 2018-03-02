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

    private let recipientTableViewCellReuseIdentifier = "RecipientTableViewCell"
    private let senderTableViewCellReuseIdentifier = "SenderTableViewCell"

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

        let top = contentInputContainer.frame.height + 16
        let bottom = contentInputContainer.frame.height + contentInputContainerBottomLayoutConstraint.constant

        tableView.contentInset.top = top
        tableView.contentInset.bottom = bottom

        tableView.scrollIndicatorInsets.top = top
        tableView.scrollIndicatorInsets.bottom = bottom
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

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel![indexPath.row]
        let cellReuseIdentifier: String

        switch message.owner {
        case .sender:
            cellReuseIdentifier = senderTableViewCellReuseIdentifier

        case .recipient:
            cellReuseIdentifier = recipientTableViewCellReuseIdentifier
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdentifier, for: indexPath) as? MessageTableViewCell else {
                assertionFailure("Expected a MessageTableViewCell")

                return UITableViewCell()
        }

        cell.viewModel = message
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        guard tableView.isDragging else { return }

        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3) { cell.transform = CGAffineTransform.identity }
    }

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

// MARK: - Target-actions
extension ChatViewController {
    @IBAction func sendButtonAction(_: UIButton) {
        view.endEditing(true)
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

        view.setNeedsLayout()
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
            nibName: senderTableViewCellReuseIdentifier,
            bundle: Bundle(for: SenderTableViewCell.self)
        )

        let recipientNib = UINib(
            nibName: recipientTableViewCellReuseIdentifier,
            bundle: Bundle(for: RecipientTableViewCell.self)
        )

        tableView.register(
            recipientNib, forCellReuseIdentifier: recipientTableViewCellReuseIdentifier
        )
        tableView.register(senderNib, forCellReuseIdentifier: senderTableViewCellReuseIdentifier)
    }
}
