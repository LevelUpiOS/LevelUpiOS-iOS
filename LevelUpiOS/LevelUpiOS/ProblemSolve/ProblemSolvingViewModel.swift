//
//  ProblemSolvingViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation
import Combine

final class ProblemSolvingViewModel {
    
    struct CurrentQuizState {
        var description: String?
        var percentage: Float
        var quizIndex: Int
    }
    
    var lastQuiz: Bool {
        return self.problemCount == self.datas.descriptions.count
    }
    
    var percentage: Float {
        return Float(self.problemCount)/Float(self.datas.descriptions.count)
    }
    
    var cancelBag = Set<AnyCancellable>()
    var problemCount = 0
    var userAnswers: [Bool] = []
    
    var datas = Problem.mockData
    
    struct Input {
        let userAnswerSubject: PassthroughSubject<Bool, Never>
        let viewwillAppearSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let viewwillAppearPublisher: AnyPublisher<(String, String), Never>
        let userAnswerPublisher: AnyPublisher<CurrentQuizState, Never>
        let lastAnwerPublisher: PassthroughSubject<Void, Never>
    }
    
    let lastAnwerPublisher = PassthroughSubject<Void, Never>()
    
    func transform(from input: Input) -> Output {
        let viewillAppearPublisher = input.viewwillAppearSubject
            .map { _ in
                self.problemCount = 0
                return (self.datas.subject, self.datas.descriptions[0])
            }
            .eraseToAnyPublisher()
        
        let userAnswerPublisher = input.userAnswerSubject
            .map { type in
                
                self.userAnswers.append(type)
                self.problemCount += 1
                
                if self.lastQuiz {
                    self.lastAnwerPublisher.send(())
                    return CurrentQuizState(description: self.datas.descriptions.last,
                                            percentage: self.percentage,
                                            quizIndex: self.datas.descriptions.count)
                }

                return CurrentQuizState(description: self.datas.descriptions[self.problemCount],
                                        percentage: self.percentage,
                                        quizIndex: self.problemCount+1)
            }
            .eraseToAnyPublisher()
        
        return Output(viewwillAppearPublisher: viewillAppearPublisher,
                      userAnswerPublisher: userAnswerPublisher,
                      lastAnwerPublisher: lastAnwerPublisher)
    }
}
