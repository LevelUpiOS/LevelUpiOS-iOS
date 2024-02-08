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
    
//    func fetchData<M: Decodable>(
//      target: T,
//      completion: @escaping (NetworkResult<M>) -> Void
//    )
    
    func request<M: Decodable>(target: T) -> AnyPublisher<M, LevelUpError> {
        
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
                    
                    // response status code 500번 -> server code
                    
                    // 200 ~ 404
                    
                    promise(.success(value))
                case .failure:
                    promise(.failure(LevelUpError.decodeError))
                }
            }
        }
        .eraseToAnyPublisher()
            
            
    }
}


enum LevelUpError: Error, CustomStringConvertible {
    case decodeError
    case inValidStatusCode(code: Int)
    case serverNoResponse
    
    var description: String {
        switch self {
        case .serverNoResponse:
            return "서버에서 빈 응답값이 옴"
        case .inValidStatusCode(code: let code):
            return "\(code)"
        case .decodeError:
            return "decoding error"
        }
    }
}
