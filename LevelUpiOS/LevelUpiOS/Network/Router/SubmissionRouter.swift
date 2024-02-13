//
//  SubmissionRouter.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation

import Alamofire

enum SubmissionRouter {
    case getSubmissions
}

extension SubmissionRouter: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getSubmissions:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getSubmissions:
            "/v1/submissions"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSubmissions:
            return .requestPlain
        }
    }
}
