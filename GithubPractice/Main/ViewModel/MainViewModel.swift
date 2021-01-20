//
//  MainViewModel.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let textInputTrigger: TextInput<UITextField>
        let reachedBottomTrigger: Observable<Void>
    }
    
    struct Output {
        let sectionModels: Observable<[MainSectionModel]>
    }
    
    private var text: String = ""
    private let sectionModels = BehaviorRelay<[MainSectionModel]>(value: [])
    
    private let searchText = BehaviorRelay<String>(value: "")
    
    var currentUsers: [User] = []
    var page = 1
    
    func transform(input: Input) -> Output {
        
        
        
//        let textInput = input.textInputTrigger
//        _ = textInput <-> searchText
//
//        searchText.asObservable()
//            .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] text in
//                guard let self = self else { return }
//
//                currentUsers.removeAll()
//                page = 1
//
//                if !text.isEmpty {
//                    self.network.fetchUser(name: text, page: String(page))
//                        .trackActivity(self.loading)
//                        .trackError(self.error)
//                        .subscribe(onNext: { [weak self] data in
//                            guard let self = self else { return }
//
//                            currentUsers = data.users
//                            let dataSource = self.genDataSource(by: data.users)
//                            self.sectionModels.accept(dataSource)
//                        })
//                        .disposed(by: self.rx.disposeBag)
//                } else {
//                    let dataSource = self.genDataSource(by: currentUsers)
//                    self.sectionModels.accept(dataSource)
//                }
//            })
//            .disposed(by: rx.disposeBag)
        
        let reachedBottomTriggered = input.reachedBottomTrigger
        reachedBottomTriggered
            .flatMapFirst { [weak self] _ -> Single<GitHubSearch> in
                guard let self = self else { return .create { (_) -> Disposable in
                    return Disposables.create()
                }}
                
                self.page += 1
                
                return self.network.fetchUser(name: self.text, page: String(self.page))
            }
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                for user in data.users {
                    if !self.currentUsers.contains(user) {
                        self.currentUsers.append(user)
                    }
                }
                
                let dataSource = self.genDataSource(by: self.currentUsers)
                self.sectionModels.accept(dataSource)
            })
            .disposed(by: self.rx.disposeBag)
        
        return Output(sectionModels: sectionModels.asObservable())
    }
    
    private func genDataSource(by users: [User]) -> [MainSectionModel] {
        let dataSource: [MainSectionModel] = [
            .main(data: users.compactMap { MainSectionItem.list(item: $0) })
        ]
        
        return dataSource
    }
    
    func fetchSearchResult(by text: String) {
        currentUsers.removeAll()
        page = 1
        
        self.text = text
        
        if !text.isEmpty {
            self.network.fetchUser(name: text, page: String(page))
                .trackActivity(self.loading)
                .trackError(self.error)
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    
                    self.currentUsers = data.users
                    let dataSource = self.genDataSource(by: data.users)
                    self.sectionModels.accept(dataSource)
                })
                .disposed(by: self.rx.disposeBag)
        } else {
            let dataSource = self.genDataSource(by: currentUsers)
            self.sectionModels.accept(dataSource)
        }
    }
}
