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
    
    let network = Network()
    
    let navigator: Navigator = Navigator.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// IQKeyboardManager Settings
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        if let window = window {
            self.navigator.show(segue: .main(viewModel: MainViewModel(network: network)), sender: nil, transition: .root(in: window))
        }
        
        return true
    }
}

