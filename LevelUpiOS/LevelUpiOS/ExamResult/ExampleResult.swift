//
//  ExampleResult.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//

import Foundation

struct ExamResult {
    var question: String
    var answer: Bool
    var isCorrect: Bool
    var explaination: String
}

extension ExamResult {
    static let dummy: [ExamResult] = [
        .init(question: "첫번째질문입니다첫번첫번째질문입니다첫번째질문입니다첫번째질문입니다첫번째질문입니다첫번째질문입니다첫번째질문", answer: true, isCorrect: false, explaination: "첫번째문제설명입니다첫번째문명입니다첫번째문제설명입니다첫번째문제설명입니다첫번째문제설명입니다첫번째문제설"),
        .init(question: "두번째질문입니다째질문입니다두번째질문입니다두번째질문입문입니다두번째질문입니다", answer: false, isCorrect: true, explaination: "두번째문제설명입니다두번째문제설명명입니다두번째문제설명입니다두번째문제설명입니다두번째문제설명입니다"),
        .init(question: "세번째질문입니다세질문입니다세입니다세번째질문입니다세번째질문입니다세번째질문입니다세번째질문입니다세번째질문입니다", answer: true, isCorrect: true, explaination: "세번째문제설명입니다세번째번째문제설명제설명입니다세번째문제설명입니다"),
        .init(question: "네번째질문입니다네번째질문입입니다네번째질문입니다", answer: false, isCorrect: false, explaination: "네번째문제설명입니설명입니다네번째문제설명입니다네번째문제설명입니다")
    ]
}
