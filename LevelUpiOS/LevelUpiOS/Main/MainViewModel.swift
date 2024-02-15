//
//  MainViewModel.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import Foundation
import Combine


final class MainViewModel: ViewModel {
    
    struct Input {
        let viewWillAppear: PassthroughSubject<Void, Never>
        let reviewButtonDidTap: PassthroughSubject<Void, Never>
        let chapterDidTap: PassthroughSubject<Int, Never>
    }

    struct Output {
        let topics: AnyPublisher<Subject, Never>
        let chapterDidTap: AnyPublisher<Int, Never>
        let reviewButtonDidTap: AnyPublisher<Void, Never>
    }
    
    private let mainServiceManager: MainServiceManager
    
    init(mainServiceManager: MainServiceManager) {
        self.mainServiceManager = mainServiceManager
    }
    
    func transform(input: Input) -> Output {
        let topics: AnyPublisher<Subject, Never> = input.viewWillAppear
            .requestAPI(failure: .empty) { _ in
                let topics = try await self.mainServiceManager.getChapters()
                
                return topics
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()

        return Output(
            topics: topics,
            chapterDidTap: input.chapterDidTap.eraseToAnyPublisher(),
            reviewButtonDidTap: input.reviewButtonDidTap.eraseToAnyPublisher()
        )
    }
    
}
