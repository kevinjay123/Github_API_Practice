//
//  BaseNavigationController.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        setUI()
    }

    private func setUI() {
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = true
        navigationBar.barStyle = .default
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
