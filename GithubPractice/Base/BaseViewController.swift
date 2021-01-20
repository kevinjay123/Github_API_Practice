//
//  BaseViewController.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class BaseViewController: UIViewController, Navigatable {

    var viewModel: BaseViewModel?
    var navigator: Navigator!

    var hud = MBProgressHUD()

    init(viewModel: BaseViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    let isLoading = BehaviorRelay(value: false)
    let error = PublishRelay<Error>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
    }

    func setUI() {
        
    }

    func bindViewModel() {

    }
}

extension BaseViewController {
    func showHUD(text: String = "", mode: MBProgressHUDMode = .indeterminate) {
        DispatchQueue.main.async {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud.mode = mode
            self.hud.label.text = text
        }
    }

    func dismissHUD(isAnimated: Bool) {
        DispatchQueue.main.async {
            self.hud.hide(animated: isAnimated)
        }
    }

    func dismissHUD(isAnimated: Bool, afterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.hud.hide(animated: isAnimated, afterDelay: afterDelay)
        }
    }
}

