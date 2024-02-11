//
//  CategoryInquiryResponse.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

struct CategoryInquiryResponse: Decodable {
    var categories: [Category]
    
    struct Category: Decodable {
        var id: Int
        var name: String
        var description: String
        var exams: [Exam]
    }
    
    struct Exam: Decodable {
        var id: Int
        var name: String
    }
}
