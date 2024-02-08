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
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        request.addValue("X_AUTH_TOKEN=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3Iiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MDczNzQzMDN9.AcOnVzuM7GGom4WFrIW6fRGFt4xXHXTbsSbefemjZcY", forHTTPHeaderField: "cookie")
        var dict: [String:String] = [:]
        
        do {
            request = try URLEncodedFormParameterEncoder().encode(dict, into: request)
        } catch {
            print(error)
        }
        
        completion(.success(request))
    }
}

