//
//  ExamRouter.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation
import Alamofire

enum ExamRouter {
    case getExamQuestions(id: Int)
    case solveExamQuestions(id: Int, answers: [Bool])
}

extension ExamRouter: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getExamQuestions:
            return .get
        case .solveExamQuestions:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getExamQuestions(let id):
            return "/v1/exams/\(id)"
        case .solveExamQuestions(let id, _):
            return "/v1/exams/\(id)"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getExamQuestions:
            return .requestPlain
        case .solveExamQuestions(_, answers: let answers):
            struct Answers: Encodable {
                var answers: [Bool]
            }
            return .requestWithBody(Answers(answers: answers))
        }
    }
}
