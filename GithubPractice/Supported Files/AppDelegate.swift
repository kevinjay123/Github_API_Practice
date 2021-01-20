//
//  AppDelegate.swift
//  GithubPratice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxViewController
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// IQKeyboardManager Settings
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        
        return true
    }
}

