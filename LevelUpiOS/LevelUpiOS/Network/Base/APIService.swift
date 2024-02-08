//
//  APIService.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/8/24.
//

import Foundation
import Combine

import Alamofire

class APIRequestLoader<T: TargetType> {
    private let configuration: URLSessionConfiguration
    private let apiLogger: APIEventLogger
    private let session: Session
    
    init(
        configuration: URLSessionConfiguration = .default,
        apiLogger: APIEventLogger
    ) {
        self.configuration = configuration
        self.apiLogger = apiLogger
        self.session = Session(configuration: configuration, eventMonitors: [apiLogger])
    }
    
    func request<M: Decodable>(target: T) -> AnyPublisher<(M, Int), LevelUpError> {
        
        return Future { promise in
            Task {
                let dataTask = self.session
                    .request(target)
                    .serializingDecodable(M.self)
                
                switch await dataTask.result {
                case .success(let value):
                    guard let response = await dataTask.response.response else {
                        promise(.failure(LevelUpError.serverNoResponse))
                        return
                    }
                    
                    switch response.statusCode {
                    case 200..<300:
                        promise(.success((value, response.statusCode)))
                    case 400:
                        promise(.failure(.requsetError))
                    case 401:
                        promise(.failure(.authError))
                    case 404:
                        promise(.failure(.noUserError))
                    case 500...:
                        promise(.failure(.serverError))
                    default:
                        promise(.failure(.unknownError))
                    }
                    

                case .failure:
                    promise(.failure(LevelUpError.decodeError))
                }
            }
        }
        .eraseToAnyPublisher()
            
            
    }
}

enum LevelUpError: Error, CustomStringConvertible {
    case unknownError
    case requsetError
    case authError
    case noUserError
    case decodeError
    case inValidStatusCode(code: Int)
    case serverNoResponse
    case serverError
    
    var description: String {
        switch self {
        case .serverNoResponse:
            return "서버에서 빈 응답값이 옴"
        case .inValidStatusCode(code: let code):
            return "\(code)"
        case .decodeError:
            return "decoding error"
        case .unknownError:
            return "명시되지 않은 오류"
        case .requsetError:
            return "클라에서 뭘빼먹고 요청함"
        case .authError:
            return "인증오류"
        case .noUserError:
            return "유저가 없음"
        case .serverError:
            return "서버오류"
        }
    }
}
