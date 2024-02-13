//
//  CategoryService.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation


final class CategoryService {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getCategories() async throws -> DecodedResponse<Categories> {
        return try await apiService.request(target: CategoryRouter.getCategory)
    }
    
}
