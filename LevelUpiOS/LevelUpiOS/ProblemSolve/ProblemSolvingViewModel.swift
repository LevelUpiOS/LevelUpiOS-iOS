//
//  ProblemSolvingViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation
import Combine

enum ProblemSolvingError: Error {
    case emptyData
}

struct CurrentQuizState {
    var description: String?
    var percentage: Float
    var quizIndex: Int
}

protocol ProblemSolvingManager {
    func getQuiz(from subjectId: Int) async throws -> Problem
}

struct ProblemSolvingManagerImpl: ProblemSolvingManager {
    func getQuiz(from subjectId: Int) async throws -> Problem {
        return Problem.mockData
    }
}

final class ProblemSolvingViewModel {
    
    let manager: ProblemSolvingManager
    
    init(manager: ProblemSolvingManager) {
        self.manager = manager
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
    
    var datas: Problem = .empty
    
    struct Input {
        let userAnswerSubject: PassthroughSubject<Bool, Never>
        let viewwillAppearSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let viewwillAppearPublisher: AnyPublisher<(String, String), Never>
        let userAnswerPublisher: AnyPublisher<CurrentQuizState, Never>
        let lastAnwerPublisher: PassthroughSubject<Void, Never>
    }
    

    
    func transform(from input: Input) -> Output {
        let lastAnwerPublisher = PassthroughSubject<Void, Never>()
        
        let viewwillAppearSubject = input.viewwillAppearSubject
            .flatMap { _ -> AnyPublisher<(String, String), Never> in
                return Future<(String, String), Error> { promise in
                    Task {
                        do {
                            let inputData = try await self.manager.getQuiz(from: 1)
                            self.datas = inputData
                            promise(.success((inputData.subject, inputData.descriptions[0])))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    return Just(("실패", "실패1"))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let userAnswerPublisher = input.userAnswerSubject
            .map { type in
                self.userAnswers.append(type)
                self.problemCount += 1
                if self.lastQuiz { lastAnwerPublisher.send(()) }
                let descriptionIndex = min(self.datas.descriptions.count-1, self.problemCount)
                let quizIndex = min(self.datas.descriptions.count, self.problemCount+1)
                return CurrentQuizState(description: self.datas.descriptions[descriptionIndex],
                                        percentage: self.percentage,
                                        quizIndex: quizIndex)
            }
            .eraseToAnyPublisher()
        
        return Output(viewwillAppearPublisher: viewwillAppearSubject,
                      userAnswerPublisher: userAnswerPublisher,
                      lastAnwerPublisher: lastAnwerPublisher)
    }
}
