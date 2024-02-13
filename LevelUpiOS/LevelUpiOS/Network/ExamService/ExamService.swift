//
//  ExamService.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation

final class ExamService {
    let apiService = APIService()
    
    func getExamQuestions(examID: Int) async throws -> (ExamQuestionInquiryResponse, Int) {
        return try await apiService.request(target: ExamRouter.getExamQuestions(id: examID))
    }
    
    func solveExamQuestions(id: Int, answers: [Bool]) async throws -> (ExamQuestionSolvingResponse, Int) {
        return try await apiService.request(target: ExamRouter.solveExamQuestions(id: id, answers: answers))
    }
}
