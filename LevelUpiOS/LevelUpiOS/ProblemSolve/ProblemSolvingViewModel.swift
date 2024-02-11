//
//  ProblemSolvingViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation
import Combine

final class ProblemSolvingViewModel {
    
    var manager = ProblemSolvingManagerImpl()
    
    var lastQuiz: Bool {
        return self.problemCount == self.descriptions.count
    }
    
    var percentage: Float {
        return Float(self.problemCount)/Float(self.descriptions.count)
    }
    
    var currentDescription: String {
        return self.descriptions[min(self.descriptions.count-1, self.problemCount)]
    }
    
    var currentQuizIndex: Int {
        return min(self.descriptions.count, self.problemCount+1)
    }
    
    var cancelBag = Set<AnyCancellable>()
    
    var problemCount = 0
    var userAnswers: [Bool] = []
    var descriptions: [String] = []
    
    var subjectId: Int?
    var bookmarks: [Bool]?
    var quizIDs: [Int]?
    
    struct Input {
        let userAnswerSubject: PassthroughSubject<Bool, Never>
        let viewwillAppearSubject: PassthroughSubject<Void, Never>
        let submitAnswerSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let viewwillAppearPublisher: AnyPublisher<String, Never>
        let userAnswerPublisher: AnyPublisher<CurrentQuizState, Never>
        let lastAnwerPublisher: AnyPublisher<Void, Never>
        let titlePublisher: AnyPublisher<String, Never>
        let submitAnswerSubject: AnyPublisher<ExamResultDTO, Never>
    }
    
    func transform(from input: Input) -> Output {
        let lastAnswerPublisher = PassthroughSubject<Void, Never>()
        let titlePublisher = PassthroughSubject<String, Never>()
        
        let viewwillAppearSubject: AnyPublisher<String, Never> = input.viewwillAppearSubject
            .requestAPI(failure: "오류발생") { _ in
                let inputData = try await self.manager.getQuiz(from: 1)
                self.descriptions = inputData.questions.map { $0.paragraph }
                self.bookmarks = inputData.questions.map { $0.bookmark }
                self.subjectId = inputData.id
                self.quizIDs = inputData.questions.map { $0.id }
                titlePublisher.send(inputData.name)
                return self.descriptions[0]
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        let userAnswerPublisher = input.userAnswerSubject
            .map { type in
                self.userAnswers.append(type)
                self.problemCount += 1
                if self.lastQuiz { lastAnswerPublisher.send(()) }
                return CurrentQuizState(description: self.currentDescription,
                                        percentage: self.percentage,
                                        quizIndex: self.currentQuizIndex)
            }
            .eraseToAnyPublisher()
        
        let submitAnswerSubject: AnyPublisher<ExamResultDTO, Never> = input.submitAnswerSubject
            .requestAPI(failure: .empty) { _ in
                guard let bookmarks = self.bookmarks,
                      let quizIDs = self.quizIDs,
                      let subjectId = self.subjectId else { return .empty }
                return try await self.manager.solveQuiz(from: subjectId, answers: self.userAnswers, bookmarkData: bookmarks, ids: quizIDs)
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        return Output(viewwillAppearPublisher: viewwillAppearSubject,
                      userAnswerPublisher: userAnswerPublisher,
                      lastAnwerPublisher: lastAnswerPublisher.eraseToAnyPublisher(),
                      titlePublisher: titlePublisher.eraseToAnyPublisher(),
                      submitAnswerSubject: submitAnswerSubject)
    }
}
