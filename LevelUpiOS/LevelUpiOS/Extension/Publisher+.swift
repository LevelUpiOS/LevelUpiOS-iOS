//
//  Publisher+.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//

import Foundation
import Combine

extension Publisher {
    func requestAPI<Output>(failure: Output,
                            handler: @escaping (Self.Output) async throws -> (Output),
                            errorHandler: @escaping ((LevelUpError) -> ())) -> AnyPublisher<Output, Never> where Self.Failure == Never {
        
        return self.flatMap { input -> AnyPublisher<Output, Never> in
                return Future<Output, LevelUpError> { promise in
                    Task {
                        do {
                            let output = try await handler(input)
                            promise(.success(output))
                        } catch {
                            let networkError = error as! LevelUpError
                            errorHandler(networkError)
                            promise(.failure(networkError))
                        }
                    }
                }
                .catch { _ in
                    Just(failure)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
