//
//  ExamQuestionInfo.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation

struct ExamQuestionInfo: Decodable {
    var id: Int
    var name: String
    var questions: [QuestionInfo]
}

struct QuestionInfo: Decodable {
    var id: Int
    var paragraph: String
    var bookmark: Bool
}
