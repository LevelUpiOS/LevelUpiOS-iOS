//
//  ProblemSolvingViewModel.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation
import Combine

struct CurrentQuizState {
    var description: String?
    var percentage: Float
    var quizIndex: Int
}

//struct examResultDTO {
//    
//}

struct ProblemSolvingManagerImpl {
    
    let examService = ExamService()
    
    func getQuiz(from subjectId: Int) async throws -> ExamQuestionInquiryDTO {
        return try await examService.getExamQuestions(examID: subjectId).0.toDTO()
    }
    
//    func solveQuiz(from subjectId: Int, answers: [Bool]) async throws ->
}

final class ProblemSolvingViewModel {
    
    var manager = ProblemSolvingManagerImpl()

    var lastQuiz: Bool {
        return self.problemCount == self.datas.count
    }
    
    var percentage: Float {
        return Float(self.problemCount)/Float(self.datas.count)
    }
    
    var currentDescription: String {
        return self.datas[min(self.datas.count-1, self.problemCount)]
    }
    
    var currentQuizIndex: Int {
        return min(self.datas.count, self.problemCount+1)
    }
    
    var cancelBag = Set<AnyCancellable>()
    
    var problemCount = 0
    var userAnswers: [Bool] = []
    var subjectId: Int?
    var bookmarks: [Bool]?
    var datas: [String] = []

    struct Input {
        let userAnswerSubject: PassthroughSubject<Bool, Never>
        let viewwillAppearSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let viewwillAppearPublisher: AnyPublisher<String, Never>
        let userAnswerPublisher: AnyPublisher<CurrentQuizState, Never>
        let lastAnwerPublisher: PassthroughSubject<Void, Never>
        let titlePublisher: PassthroughSubject<String, Never>
    }
    
    func transform(from input: Input) -> Output {
        let lastAnwerPublisher = PassthroughSubject<Void, Never>()
        let titlePublisher = PassthroughSubject<String, Never>()
        
        let viewwillAppearSubject: AnyPublisher<String, Never> = input.viewwillAppearSubject
            .requestAPI(failure: "오류발생") { _ in
                let inputData = try await self.manager.getQuiz(from: 1)
                self.datas = inputData.questions.map { $0.paragraph }
                self.bookmarks = inputData.questions.map { $0.bookmark }
                titlePublisher.send(inputData.name)
                return self.datas[0]
            } errorHandler: { error in
                print(error)
            }
            .eraseToAnyPublisher()
        
        let userAnswerPublisher = input.userAnswerSubject
            .map { type in
                self.userAnswers.append(type)
                self.problemCount += 1
                if self.lastQuiz { lastAnwerPublisher.send(()) }
                return CurrentQuizState(description: self.currentDescription,
                                        percentage: self.percentage,
                                        quizIndex: self.currentQuizIndex)
            }
            .eraseToAnyPublisher()
        
        return Output(viewwillAppearPublisher: viewwillAppearSubject,
                      userAnswerPublisher: userAnswerPublisher,
                      lastAnwerPublisher: lastAnwerPublisher,
                      titlePublisher: titlePublisher)
    }
}
