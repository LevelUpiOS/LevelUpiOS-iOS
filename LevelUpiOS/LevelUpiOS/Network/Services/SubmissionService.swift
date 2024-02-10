//
//  SubmissionService.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation

final class SubmissionService {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getSubmissions() async throws -> DecodedResponse<SubmissionResponse> {
        return try await apiService.request(target: SubmissionRouter.getSubmissions)
    }
    
}
