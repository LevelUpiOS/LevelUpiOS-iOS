//
//  Bookmark.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/5/24.
//

import Foundation

struct Bookmark {
    var question: String
    var answer: Bool
    var description: String
    var source: String
}

extension Bookmark {
    static let mock: [Bookmark] = [
        .init(question: "1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제1번문제", answer: true, description: "1번문제해답", source: "swift > optional"),
        .init(question: "2번문제", answer: false, description: "2번문제해답", source: "메모리관리 > ARC"),
        .init(question: "3번문제", answer: true, description: "3번문제해답", source: "FRP > Combine")
    ]
}
