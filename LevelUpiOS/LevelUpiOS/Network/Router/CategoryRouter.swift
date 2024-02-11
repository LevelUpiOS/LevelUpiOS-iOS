//
//  CategoryRouter.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation
import Alamofire

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
