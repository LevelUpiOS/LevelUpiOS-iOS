//
//  AuthRouter.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation

import Alamofire

enum AuthRouter {
    case getCookie
}

extension AuthRouter: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getCookie:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getCookie:
            "/v1/auth"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCookie:
            return .requestPlain
        }
    }
}
