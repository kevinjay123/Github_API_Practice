//
//  MainViewModelTest.swift
//  GithubPracticeTests
//
//  Created by Kevin Chan on 2021/1/21.
//

import Nimble
import Quick
import RxCocoa
import RxSwift
import XCTest

@testable import GithubPractice

class MainViewModelTest: QuickSpec {
    override func spec() {
        super.spec()
        
        var viewModel: MainViewModel!
        var dummyNetwork: GithubAPI!
        var disposeBag: DisposeBag!
        
        beforeEach {
            dummyNetwork = DummyNetwork()
            disposeBag = DisposeBag()
            viewModel = MainViewModel(network: dummyNetwork)
        }
        
        describe("MainViewModel Test") {
            it("Normal") {
                viewModel.fetchSearchResult(by: "Kevin")
                self.testViewModel(viewModel: viewModel, disposeBag: disposeBag)
            }
            
            it("Reached Bottom") {
                viewModel.fetchSearchResult(by: "Kevin")
                self.testViewModel(viewModel: viewModel, disposeBag: disposeBag, isReachedBottom: true)
            }
            
            it("Error") {
                viewModel.fetchSearchResult(by: "")
                self.testViewModel(viewModel: viewModel, disposeBag: disposeBag)
            }
        }
        
        afterEach {
            dummyNetwork = nil
            viewModel = nil
            disposeBag = nil
        }
    }
    
    func testViewModel(viewModel: MainViewModel, disposeBag: DisposeBag, isReachedBottom: Bool = false) {
        let trigger = PublishSubject<Void>()
        let error = PublishRelay<Error>()
        
        let input = MainViewModel.Input(reachedBottomTrigger: trigger.mapToVoid())
        let output = viewModel.transform(input: input)
        
        if isReachedBottom {
            trigger.onNext(())
        }
        
        output.sectionModels
            .subscribe(onNext: { models in
                if let model = models.first {
                    switch model {
                    case let .main(datas):
                        if datas.count > 1 {
                            expect(datas.count).to(equal(3))
                            
                            if let data = datas.last {
                                switch data {
                                case let .list(item):
                                    expect(item.name).to(equal("Lu"))
                                    expect(item.avatarUrlString).to(equal("www.youtube.com"))
                                }
                            }
                        } else {
                            if let data = datas.first {
                                switch data {
                                case let .list(item):
                                    expect(item.name).to(equal("Kevin"))
                                    expect(item.avatarUrlString).to(equal("www.google.com"))
                                }
                            }
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.parsedError.asObservable()
            .bind(to: error)
            .disposed(by: disposeBag)
        
        error
            .subscribe(onNext: { error in
                if let error = error as? ServiceError {
                    expect(error).to(matchError(ServiceError.data))
                }
            })
            .disposed(by: disposeBag)
    }
}
