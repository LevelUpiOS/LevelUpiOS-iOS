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
    let chapters: [Chapter]
}

// Closure, Optional, Struct and Classes etc.
struct Chapter {
    let name: String
    let score: Int?
    let questions: [Question]
}


struct Question {
    let content: String
    let answer: Bool
    let isCorrect: Bool?
}


extension Subject {
    static var dummy: Subject = .init(name: "iOS", topics: [
        Topic(name: "Swift", chapters: [
            Chapter(name: "Optional", score: nil, questions: [
                Question(content: iOS.Swift.Optional.question1, answer: true, isCorrect: nil),
                Question(content: iOS.Swift.Optional.question2, answer: true, isCorrect: nil),
                Question(content: iOS.Swift.Optional.question3, answer: true, isCorrect: nil)
            ])
        ]),
        Topic(name: "Swift의 메모리 관리", chapters: [
            Chapter(name: "ARC", score: nil, questions: [
                Question(content: iOS.Memory.ARC.question1, answer: true, isCorrect: nil),
                Question(content: iOS.Memory.ARC.question2, answer: true, isCorrect: nil),
                Question(content: iOS.Memory.ARC.question3, answer: true, isCorrect: nil)
            ])
        ]),
        Topic(name: "UIKit", chapters: [
            Chapter(name: "LifeCycle", score: nil, questions: [
                Question(content: iOS.UIKit.LifeCycle.question1, answer: true, isCorrect: nil),
                Question(content: iOS.UIKit.LifeCycle.question2, answer: true, isCorrect: nil),
                Question(content: iOS.UIKit.LifeCycle.question3, answer: true, isCorrect: nil)
            ])
        ]),
    ])
}
