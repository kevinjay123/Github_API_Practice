//
//  AppDelegate.swift
//  GithubPratice
//
//  Created by Kevin Chan on 2021/1/20.
//

import IQKeyboardManagerSwift
import NSObject_Rx
import RxCocoa
import RxSwift
import RxViewController
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let network = Network()

    let navigator = Navigator.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        /// IQKeyboardManager Settings
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = NSLocalizedString("UI.Done", comment: "UI.Done")

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        if let window = window {
            navigator.show(segue: .main(viewModel: MainViewModel(network: network)), sender: nil, transition: .root(in: window))
        }

        return true
    }
}
