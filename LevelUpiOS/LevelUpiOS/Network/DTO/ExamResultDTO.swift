//
//  ExamResultDTO.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

struct ExamResultDTO {
    var id: Int
    var examId: Int
    var score: Int
    var results: [ExamResultPerQuiz]
    
    struct ExamResultPerQuiz {
        var id: Int
        var description: String
        var explanation: String
        var userAnser: Bool
        var answer: Bool
        var isCorrect: Bool
        var isBookmarked: Bool
    }
}

extension ExamResultDTO {
    static var empty: Self {
        return .init(id: 0, examId: 0, score: 0, results: [])
    }
}
