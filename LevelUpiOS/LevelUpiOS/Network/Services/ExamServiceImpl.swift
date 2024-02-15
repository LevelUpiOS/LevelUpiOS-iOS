//
//  ExamServiceImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation

protocol ExamService {
    func getExamQuestions(examID: Int) async throws -> (ExamQuestionInquiryResponse, Int)
    func solveExamQuestions(id: Int, answers: [Bool]) async throws -> (ExamQuestionSolvingResponse, Int)
}

final class ExamServiceImpl: ExamService {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getExamQuestions(examID: Int) async throws -> (ExamQuestionInquiryResponse, Int) {
        return try await apiService.request(target: ExamRouter.getExamQuestions(id: examID))
    }
    
    func solveExamQuestions(id: Int, answers: [Bool]) async throws -> (ExamQuestionSolvingResponse, Int) {
        return try await apiService.request(target: ExamRouter.solveExamQuestions(id: id, answers: answers))
    }
}
