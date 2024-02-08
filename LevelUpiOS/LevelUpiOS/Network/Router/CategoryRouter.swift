//
//  CategoryRouter.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation

import Alamofire

struct CategoryDatas: Decodable {
    var categsories: [CategoryData]
}

struct CategoryData: Decodable {
    var id: Int
    var name: String
    var description: String
    var exams: [Exam]
}

struct Exam: Decodable {
    var id: Int
    var name: String
}

enum CategoryRouter {
    case getCategory
}

extension CategoryRouter: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getCategory:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCategory:
            "/v1/categories"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCategory:
            return .requestPlain
        }
    }
}
