//
//  ProblemSolvingManagerImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

protocol ProblemSolvingManager {
    func getQuiz(from subjectId: Int) async throws -> ExamQuestionInquiryDTO
    func solveQuiz(from subjectId: Int, answers: [Bool]) async throws -> ExamResultDTO
}

final class ProblemSolvingManagerImpl: ProblemSolvingManager {
    
    let examService: ExamService
    
    init(examService: ExamService) {
        self.examService = examService
    }
    
    func getQuiz(from subjectId: Int) async throws -> ExamQuestionInquiryDTO {
        return try await examService.getExamQuestions(examID: subjectId).0.toDTO()
    }
    
    func solveQuiz(from subjectId: Int, answers: [Bool]) async throws -> ExamResultDTO {
        let response = try await examService.solveExamQuestions(id: subjectId, answers: answers).0
        let resultDTO = response.results.map { ExamResultDTO.ExamResultPerQuiz(questionId: $0.questionId, description: $0.question, explanation: $0.explanation, userAnswer: $0.guess, answer: $0.answer, isCorrect: $0.isCorrect, bookmark: $0.bookmark) }
        return .init(id: response.id, examId: response.examId, score: Int(response.score), results: resultDTO)
    }
}
