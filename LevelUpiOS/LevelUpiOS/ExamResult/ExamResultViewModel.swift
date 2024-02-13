//
//  ExamResultViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/12/24.
//

import Foundation
import Combine

final class ExamResultViewModel {
    var cancelBag = Set<AnyCancellable>()
    var data: ExamResultDTO
    let bookmarkService = BookmarkService()
    init(data: ExamResultDTO) {
        self.data = data
    }
    
    struct Input {
        let bookmarkTap: PassthroughSubject<(Int, Int?), Never>
        let viewWillAppearSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let reloadPublisher: AnyPublisher<ExamResultDTO, Never>
    }
    
    func transform(from input: Input) -> Output {
        let bookmarkPublisher: AnyPublisher<ExamResultDTO, Never> = input.bookmarkTap
            .requestAPI(failure: .empty) { index, id in
                guard let id else { return .empty }
                if self.data.results[index].bookmark {
                    _ = try await self.bookmarkService.deleteBookmark(id: id)
                } else {
                    _ = try await self.bookmarkService.makeBookmark(id: id)
                }
                self.data.results[index].bookmark.toggle()
                return self.data
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        let viewWillAppearPublisher = input.viewWillAppearSubject
            .map { _ in
                return self.data
            }
            .eraseToAnyPublisher()
        
        
        let reloadPublisher = viewWillAppearPublisher.merge(with: bookmarkPublisher)
            .eraseToAnyPublisher()
        return Output(reloadPublisher: reloadPublisher)
    }
}
