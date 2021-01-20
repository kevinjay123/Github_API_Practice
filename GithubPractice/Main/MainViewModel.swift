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
        let trigger: Observable<Void>
    }
    
    struct Output {
        let sectionModels: Observable<[MainSectionModel]>
    }
    
    private var text: String = ""
    private let sectionModels = BehaviorRelay<[MainSectionModel]>(value: [])
    
    func transform(input: Input) -> Output {
        
        let triggered = input.trigger
        triggered
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.network.fetchUser(name: "Kevin", page: "1")
                    .trackActivity(self.loading)
                    .trackError(self.error)
                    .subscribe(onNext: { [weak self] data in
                        guard let self = self else { return }
                        
                        let dataSource = self.genDataSource(by: data.users)
                        self.sectionModels.accept(dataSource)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        return Output(sectionModels: sectionModels.asObservable())
    }
    
    private func genDataSource(by users: [User]) -> [MainSectionModel] {
        let dataSource: [MainSectionModel] = [
            .main(data: users.compactMap { MainSectionItem.list(item: $0) })
        ]
        
        return dataSource
    }
}
