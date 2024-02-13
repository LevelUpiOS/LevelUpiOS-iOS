//
//  APIService.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/8/24.
//

import Foundation
import Combine

import Alamofire

final class APIService {
    private let configuration: URLSessionConfiguration
    private let apiLogger: APIEventLogger
    private let session: Session
    
    init(
        configuration: URLSessionConfiguration = .default,
        apiLogger: APIEventLogger = APIEventLogger()
    ) {
        self.configuration = configuration
        self.apiLogger = apiLogger
        self.session = Session(configuration: configuration, interceptor: BaseInterceptor(), eventMonitors: [apiLogger])
    }
    

    func request<M: Decodable>(target: TargetType) async throws -> DecodedResponse<M> {
        let dataTask = self.session
            .request(target)
            .serializingData()
        
        switch await dataTask.result {
        case .success(let value):
            guard let response = await dataTask.response.response else {
                throw LevelUpError.serverNoResponse
            }
            
            do {
                switch response.statusCode {
                case 200..<300:
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(M.self, from: value)
                    return DecodedResponse(
                        decodedData: decodedData,
                        statusCode: response.statusCode
                    )
                case 401:
                    throw LevelUpError.authError
                case 404:
                    throw LevelUpError.noUserError
                case 500...:
                    throw LevelUpError.serverError
                default:
                    throw LevelUpError.unknownError
                }
            } catch {
                throw LevelUpError.decodingError
            }
        case .failure(let error):
            throw LevelUpError.requestError(error: error)
        }
    }
    
    func request<M: Decodable>(target: TargetType) async throws -> (M, Int) {
            let dataTask = self.session
                .request(target)
                .serializingData()
            
            switch await dataTask.result {
            case .success(let value):
                guard let response = await dataTask.response.response else {
                    throw LevelUpError.serverNoResponse
                }
                
                do {
                    switch response.statusCode {
                    case 200..<300:
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(M.self, from: value)
                        return (decodedData, response.statusCode)
                    case 401:
                        throw LevelUpError.authError
                    case 404:
                        throw LevelUpError.noUserError
                    case 500...:
                        throw LevelUpError.serverError
                    default:
                        throw LevelUpError.unknownError
                    }
                } catch {
                    throw LevelUpError.decodingError
                }
            case .failure(let error):
                throw LevelUpError.requestError(error: error)
            }
        }
    
    // response가 statuscode만 있는 경우
    func request(target: TargetType) async throws -> Int {
        let dataTask = self.session
            .request(target)
            .serializingData()
        
        switch await dataTask.result {
        case .success:
            guard let response = await dataTask.response.response else {
                throw LevelUpError.serverNoResponse
            }
            
            do {
                switch response.statusCode {
                case 200..<300:
                    return response.statusCode
                case 401:
                    throw LevelUpError.authError
                case 404:
                    throw LevelUpError.noUserError
                case 500...:
                    throw LevelUpError.serverError
                default:
                    throw LevelUpError.unknownError
                }
            } catch {
                throw LevelUpError.decodingError
            }
        case .failure(let error):
            throw LevelUpError.requestError(error: error)
        }
    }
    
}

enum LevelUpError: Error, CustomStringConvertible {
    case unknownError
    case authError
    case noUserError
    case requestError(error: Error)
    case inValidStatusCode(code: Int)
    case serverNoResponse
    case serverError
    case decodingError
    
    var description: String {
        switch self {
        case .serverNoResponse:
            return "서버에서 빈 응답값이 옴"
        case .inValidStatusCode(code: let code):
            return "\(code)"
        case .unknownError:
            return "명시되지 않은 오류"
        case .requestError(let error):
            return "\(error)"
        case .authError:
            return "인증오류"
        case .noUserError:
            return "유저가 없음"
        case .serverError:
            return "서버오류"
        case .decodingError:
            return "디코딩에러"
        }
    }
}
