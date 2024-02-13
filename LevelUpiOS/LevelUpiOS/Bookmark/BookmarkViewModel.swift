//
//  BookmarkViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/13/24.
//

import Foundation
import Combine

final class BookmarkViewModel {
    let service = BookmarkService()

    var cancelBag = Set<AnyCancellable>()
    
    private var datas: [BookmarkDTO] = []
    
    struct Input {
        let viewWillAppearSubject: PassthroughSubject<Void, Never>
        let bookmarkTap: PassthroughSubject<(index: Int, id: Int), Never>
        let cellTap: PassthroughSubject<Int, Never>
    }
    
    struct Output {
        let reloadPublisher: AnyPublisher<[BookmarkDTO], Never>
        let presentDetailSheetPublisher: AnyPublisher<ProblemDetail, Never>
    }
    
    struct ProblemDetail {
        var question: String
        var answer: Bool
        var explain: String
    }
    
    func transform(from input: Input) -> Output {
        let viewWillAppearPublisher: AnyPublisher<[BookmarkDTO], Never> = input.viewWillAppearSubject
            .requestAPI(failure: []) { _ in
                let bookmarkResponse = try await self.service.getBookmakrList()
                let bookmarkData = bookmarkResponse.0.toDTO
                self.datas = bookmarkData
                return self.datas
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
            
        
        let bookmarkTapPublisher: AnyPublisher<[BookmarkDTO], Never> = input.bookmarkTap
            .requestAPI(failure: []) { index, id in
                _ = try await self.service.deleteBookmark(id: id)
                self.datas.remove(at: index)
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

        return Output(reloadPublisher: reloadPublisher, presentDetailSheetPublisher: presentDetailSheetPublisher)
    }
    
}
