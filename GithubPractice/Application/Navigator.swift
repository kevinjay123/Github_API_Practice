//
//  Navigator.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()

    enum Transition {
        case root(in: UIWindow)
        case navigation
        case modal(isFullScreen: Bool = true)
        case detail
        case alert
        case custom
    }

    private func get(segue: Scene) -> UIViewController? {
        switch segue {
        case let .main(viewModel):
            return MainViewController(viewModel: viewModel, navigator: self)
        }
    }

    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }

    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation) {
        if let vc = get(segue: segue) {
            show(target: vc, sender: sender, transition: transition)
        }
    }

    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case let .root(in: window):
            let nav = BaseNavigationController(rootViewController: target)
            window.rootViewController = nav
            return
        default:
            break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        switch transition {
        case .navigation:
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.pushViewController(target, animated: true)
            }
        case let .modal(isFullScreen):
            // present modally
            DispatchQueue.main.async {
                let nav = BaseNavigationController(rootViewController: target)
                nav.modalPresentationStyle = isFullScreen ? .fullScreen : .popover

                sender.present(nav, animated: true, completion: nil)
            }

        case .detail:
            DispatchQueue.main.async {
                let nav = BaseNavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        default:
            break
        }
    }
}
