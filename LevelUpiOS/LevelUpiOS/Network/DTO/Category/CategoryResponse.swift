//
//  CategoryResponse.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/8/24.
//

import Foundation

struct Categories: Decodable {
    var categories: [Category]
}

struct Category: Decodable {
    var id: Int // 1
    var name: String // Swift
    var description: String // 문법어쩌구~
    var exams: [Exam]
}

struct Exam: Decodable {
    var id: Int
    var name: String
}

extension Categories {
    static let empty = Categories(categories: [])
}
