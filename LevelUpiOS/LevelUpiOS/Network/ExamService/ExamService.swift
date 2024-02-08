//
//  ExamService.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation

struct ExamAnswer: Decodable {
    var id: Int
    var examId: Int
    var score: Int
    var results: [QuestionResult]
}

struct QuestionResult: Decodable {
    var question: String
    var guess: Bool
    var answer: Bool
    var explanation: String
}

final class ExamService {
    let apiService = APIService()
    
    func getExamQuestions(examID: Int) async throws -> (ExamQuestionInfo, Int) {
        return try await apiService.request(target: ExamRouter.getExamQuestions(id: examID))
    }
    
    func solveExamQuestions(id: Int, answers: [Bool]) async throws -> (ExamAnswer, Int) {
        return try await apiService.request(target: ExamRouter.solveExamQuestions(id: id, answers: answers))
    }
}
