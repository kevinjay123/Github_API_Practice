//
//  BaseViewModel.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class BaseViewModel: NSObject {
    let loading = ActivityIndicator()

    let error = ErrorTracker()
    let parsedError = PublishSubject<Error>()

    let network: GitHubAPI

    init(network: GitHubAPI) {
        self.network = network
        super.init()

        error.asObservable()
            .map { (error) -> Error? in
                error
            }
            .filterNil()
            .bind(to: parsedError)
            .disposed(by: rx.disposeBag)
    }
}
