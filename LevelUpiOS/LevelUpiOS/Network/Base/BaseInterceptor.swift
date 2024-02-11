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
        request.addValue("X_AUTH_TOKEN=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3Iiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MDczNzQzMDN9.AcOnVzuM7GGom4WFrIW6fRGFt4xXHXTbsSbefemjZcY", forHTTPHeaderField: "cookie")

        completion(.success(request))
    }
}

