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
    var cancelBag = Set<AnyCancellable>()
    
    var problemCount = 0
    var userAnswers: [Bool] = []
    var descriptions: [String] = []
    
    var subjectId: Int
    
    init(id: Int) {
        self.subjectId = id
    }
    
    struct Input {
        let userAnswerSubject: PassthroughSubject<Bool, Never>
        let viewwillAppearSubject: PassthroughSubject<Void, Never>
        let submitAnswerSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let viewwillAppearPublisher: AnyPublisher<(String, String), Never>
        let userAnswerPublisher: AnyPublisher<CurrentQuizState, Never>
        let lastAnwerPublisher: AnyPublisher<Void, Never>
        let resultPublisher: AnyPublisher<ExamResultDTO, Never>
    }
    
    func transform(from input: Input) -> Output {
        let lastAnswerPublisher = PassthroughSubject<Void, Never>()
        
        let viewwillAppearSubject: AnyPublisher<(String, String), Never> = input.viewwillAppearSubject
            .requestAPI(failure: ("오류발생", "오류발생")) { _ in
                let inputData = try await self.manager.getQuiz(from: self.subjectId)
                self.descriptions = inputData.questions.map { $0.paragraph }
                return (inputData.questions[0].paragraph, inputData.name)
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
                return try await self.manager.solveQuiz(from: self.subjectId, answers: self.userAnswers)
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        return Output(viewwillAppearPublisher: viewwillAppearSubject,
                      userAnswerPublisher: userAnswerPublisher,
                      lastAnwerPublisher: lastAnswerPublisher.eraseToAnyPublisher(),
                      resultPublisher: submitAnswerSubject)
    }
}

private extension ProblemSolvingViewModel {
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
}
