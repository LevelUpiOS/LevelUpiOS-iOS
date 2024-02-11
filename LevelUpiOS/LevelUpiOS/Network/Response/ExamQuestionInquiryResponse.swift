//
//  ExamQuestionInquiryResponse.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

struct ExamQuestionInquiryResponse: Decodable {
    var id: Int
    var name: String
    var questions: [Question]
    
    struct Question: Decodable {
        var id: Int
        var paragraph: String
        var bookmark: Bool
    }
}
