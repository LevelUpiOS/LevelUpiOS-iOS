//
//  ProblemSolvingManagerImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

final class ProblemSolvingManagerImpl {
    
    let examService = ExamService()
    
    func getQuiz(from subjectId: Int) async throws -> ExamQuestionInquiryDTO {
        return try await examService.getExamQuestions(examID: subjectId).0.toDTO()
    }
    
    func solveQuiz(from subjectId: Int, answers: [Bool], bookmarkData: [Bool], ids: [Int]) async throws -> ExamResultDTO {
        let resultResponse = try await examService.solveExamQuestions(id: subjectId, answers: answers).0
        return .init(id: resultResponse.id,
                     examId: resultResponse.examId,
                     score: resultResponse.score,
                     results: resultResponse.results.enumerated().map { .init(id: ids[$0],
                                                                              description: $1.question,
                                                                              explanation: $1.explanation,
                                                                              userAnser: answers[$0],
                                                                              answer: $1.answer,
                                                                              isCorrect: $1.isCorrect,
                                                                              isBookmarked: bookmarkData[$0])
        })
    }
}
