//
//  BookmarkViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/13/24.
//

import Foundation
import Combine

final class BookmarkViewModel {
    let manager: BookmarkManger
    
    init(manager: BookmarkManger) {
        self.manager = manager
    }

    var cancelBag = Set<AnyCancellable>()
    
    private var datas: [BookmarkDTO] = []
    
    struct Input {
        let viewWillAppearSubject: PassthroughSubject<Void, Never>
        let bookmarkTap: PassthroughSubject<(index: Int, id: Int), Never>
        let cellTap: PassthroughSubject<Int, Never>
        let reportTap: PassthroughSubject<Int, Never>
    }
    
    struct Output {
        let reloadPublisher: AnyPublisher<[BookmarkDTO], Never>
        let presentDetailSheetPublisher: AnyPublisher<ProblemDetail, Never>
        let reportPublisher: AnyPublisher<Int, Never>
    }
    
    struct ProblemDetail {
        var question: String
        var answer: Bool
        var explain: String
    }
    
    func transform(from input: Input) -> Output {
        let viewWillAppearPublisher: AnyPublisher<[BookmarkDTO], Never> = input.viewWillAppearSubject
            .requestAPI(failure: []) { _ in
                let bookmarkData = try await self.manager.getBookmakrList(isBookmared: true)
                self.datas = bookmarkData
                return self.datas
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
            
        
        let bookmarkTapPublisher: AnyPublisher<[BookmarkDTO], Never> = input.bookmarkTap
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: false)
            .requestAPI(failure: []) { index, id in
                self.datas.remove(at: index)
                _ = try await self.manager.deleteBookmark(id: id)
                return self.datas
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        let reloadPublisher = viewWillAppearPublisher.merge(with: bookmarkTapPublisher)
            .eraseToAnyPublisher()

        let presentDetailSheetPublisher = input.cellTap
            .map { index in
                let element = self.datas[index]
                return ProblemDetail(question: element.question, answer: element.answer, explain: element.description)
            }
            .eraseToAnyPublisher()

        return Output(reloadPublisher: reloadPublisher, presentDetailSheetPublisher: presentDetailSheetPublisher, reportPublisher: input.reportTap.eraseToAnyPublisher())
    }
    
}
