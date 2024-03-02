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
    let examResultManager: ExamResultManager
    
    init(data: ExamResultDTO, examResultManager: ExamResultManager) {
        self.data = data
        self.examResultManager = examResultManager
    }
    
    struct Input {
        let bookmarkTap: PassthroughSubject<(Int, Int?), Never>
        let reportTap: PassthroughSubject<Int, Never>
    }
    
    struct Output {
        let reportAlertPublisher: AnyPublisher<Int, Never>
        let reloadPublisher: AnyPublisher<ExamResultDTO, Never>
    }
    
    func transform(from input: Input) -> Output {
        let reloadPublisher: AnyPublisher<ExamResultDTO, Never> = input.bookmarkTap
            .requestAPI(failure: .empty) { index, id in
                guard let id else { return .empty }
                if self.data.results[index].bookmark {
                    _ = try await self.examResultManager.deleteBookmark(id: id)
                } else {
                    _ = try await self.examResultManager.getBookmark(id: id)
                }
                self.data.results[index].bookmark.toggle()
                return self.data
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        return Output(reportAlertPublisher: input.reportTap.eraseToAnyPublisher(), reloadPublisher: reloadPublisher)
    }
}
