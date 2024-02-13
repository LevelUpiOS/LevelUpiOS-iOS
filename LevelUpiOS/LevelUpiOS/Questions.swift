//
//  Questions.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/22/24.
//

import Foundation

struct Subject {
    let topics: [Topic]
    let totalCount: Int
    let solvedCount: Int
}

// Swift, ARC ...
struct Topic {
    let name: String
    let subname: String
    let chapters: [Chapter]
}

// Closure, Optional, Struct and Classes etc.
struct Chapter {
    let id: Int
    let name: String
    let solveType: ChapterSolveType
}

enum ChapterSolveType {
    case yet
    case solved(score: Int)
}

struct Question {
    let content: String
    let answer: Bool
    let isCorrect: Bool?
}

extension Subject {
    static let empty = Subject(
        topics: [],
        totalCount: 0,
        solvedCount: 0
    )
}
