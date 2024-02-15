//
//  BaseInterceptor.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation
import Alamofire

final class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.addValue(UserDefaultsManager.tokenKey?.cookie ?? "", forHTTPHeaderField: "cookie")
        completion(.success(request))
    }
}

