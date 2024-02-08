//
//  Problem.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//

import Foundation

struct Problem {
    var subject: String
    var descriptions: [String]
}

extension Problem {
    static var empty: Self {
        return .init(subject: "", descriptions: [])
    }
    
    static let mockData: Self = .init(subject: "Optional", descriptions: [
        "1번 문제의 description입니다",
        "2번 문제의 description입니다",
        "3번 문제의 description입니다",
        "4번 문제의 description입니다",
        "5번 문제의 description입니다",
        "6번 문제의 description입니다"
    ])
}
