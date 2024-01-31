//
//  Questions.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/22/24.
//

import Foundation

// iOS, CS ...
struct Subject {
    let name: String
    let topics: [Topic]
}

// Swift, ARC ...
struct Topic {
    let name: String
    let subname: String
    let chapters: [Chapter]
}

// Closure, Optional, Struct and Classes etc.
struct Chapter {
    let name: String
    let solveType: ChapterSolveType
    let questions: [Question]
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
    static var dummy: Subject = .init(name: "iOS", topics: [
        Topic(name: "Swift",
              subname: "Swift 문법이 걱정된다면?",
              chapters: [
            Chapter(name: "Optional",
                    solveType: .solved(score: 90),
                    questions: [
                Question(content: iOS.Swift.Optional.question1, answer: true, isCorrect: nil),
                Question(content: iOS.Swift.Optional.question2, answer: true, isCorrect: nil),
                Question(content: iOS.Swift.Optional.question3, answer: true, isCorrect: nil)
            ])
        ]),
        Topic(name: "Swift의 메모리 관리",
              subname: "ARC, weak self가 헷갈린다면?",
              chapters: [
            Chapter(name: "ARC",
                    solveType: .yet,
                    questions: [
                Question(content: iOS.Memory.ARC.question1, answer: true, isCorrect: nil),
                Question(content: iOS.Memory.ARC.question2, answer: true, isCorrect: nil),
                Question(content: iOS.Memory.ARC.question3, answer: true, isCorrect: nil)
            ])
        ]),
        Topic(name: "UIKit",
              subname: "MVC, MVVM이 너무 헷갈린다면?",
              chapters: [
            Chapter(name: "LifeCycle",
                    solveType: .solved(score: 100),
                    questions: [
                Question(content: iOS.UIKit.LifeCycle.question1, answer: true, isCorrect: nil),
                Question(content: iOS.UIKit.LifeCycle.question2, answer: true, isCorrect: nil),
                Question(content: iOS.UIKit.LifeCycle.question3, answer: true, isCorrect: nil)
            ])
        ]),
    ])
}
