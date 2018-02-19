//
//  AppDelegate.swift
//  ChatView
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - Application Delegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = ConversationTableViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        rootViewController.viewModel = MockDataGenerator.conversations

        // The ol' fashioned way.
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true
    }
}
