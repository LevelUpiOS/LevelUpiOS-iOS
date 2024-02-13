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

extension ExamQuestionInquiryResponse {
    func toDTO() -> ExamQuestionInquiryDTO {
        return .init(id: self.id, name: self.name, questions: self.questions.map {
            return ExamQuestionInquiryDTO.Question(id: $0.id, paragraph: $0.paragraph, bookmark: $0.bookmark)
        })
    }
}
