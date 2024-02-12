//
//  ExamResultWithUserInfoDTO.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/12/24.
//

import Foundation

struct ExamResultWithUserInfoDTO {
    var id: Int
    var examId: Int
    var score: Int
    var results: [ExamResultWithBookmark]
    
    struct ExamResultWithBookmark {
        var id: Int
        var description: String
        var explanation: String
        var userAnswer: Bool
        var answer: Bool
        var isCorrect: Bool
        var isBookmarked: Bool
    }
}
