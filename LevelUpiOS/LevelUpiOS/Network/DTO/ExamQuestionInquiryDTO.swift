//
//  ExamQuestionInquiryDTO.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation

struct ExamQuestionInquiryDTO: Decodable {
    var id: Int
    var name: String
    var questions: [Question]
    
    struct Question: Decodable {
        var id: Int
        var paragraph: String
        var bookmark: Bool
    }
}

