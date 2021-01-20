//
//  MainViewSectionModel.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import RxDataSources

enum MainSectionModel {
    case main(data: [MainSectionItem])
}

enum MainSectionItem {
    case list(item: User)
}

extension MainSectionModel: SectionModelType {
    
    typealias Item = MainSectionItem

    init(original: MainSectionModel, items: [MainSectionItem]) {
        switch original {
        case .main:
            self = .main(data: items)
        }
    }

    var items: [MainSectionItem] {
        switch self {
        case let .main(data):
            return data.map { $0 }
        }
    }
}
