//
//  AuthService.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation

final class AuthService {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getCookie() async throws -> DecodedResponse<AuthResponse> {
        return try await apiService.request(target: AuthRouter.getCookie)
    }
    
}
