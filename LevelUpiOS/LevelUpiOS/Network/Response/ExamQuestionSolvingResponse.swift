//
//  ExamQuestionSolvingResponse.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

struct ExamQuestionSolvingResponse: Decodable {
    var id: Int
    var examId: Int
    var score: Int
    var results: [QuestionResult]
    
    struct QuestionResult: Decodable {
        var question: String
        var guess: Bool
        var answer: Bool
        var explanation: String
    }
}