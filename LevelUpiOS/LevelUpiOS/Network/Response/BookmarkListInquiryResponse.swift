//
//  BookmarkListInquiryResponse.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

struct BookmarkListInquiryResponse: Decodable {
    var questions: [Question]
    
    struct Question: Decodable {
        var id: Int
        var paragraph: String
        var solution: Solution
        var category: Category
        var exam: Exam
    }
    
    struct Solution: Codable {
        var answer: Bool
        var explanation: String
    }
    
    struct Category: Codable {
        var id: Int
        var name: String
    }
    
    struct Exam: Codable {
        let id: Int
        let name: String
    }
}

extension BookmarkListInquiryResponse {
    var toDTO: [BookmarkDTO] {
        return self.questions.map {
            let source = "\($0.category.name) > \($0.exam.name)"
            return .init(id: $0.id, question: $0.paragraph, answer: $0.solution.answer, description: $0.solution.explanation, source: source)
        }
    }
}
