//
//  BookmarkServiceImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

protocol BookmarkService {
    func getBookmakrList(isBookmared: Bool) async throws -> (BookmarkListInquiryResponse, Int)
    func makeBookmark(id: Int) async throws -> Int
    func deleteBookmark(id: Int) async throws -> Int
}

final class BookmarkServiceImpl: BookmarkService {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getBookmakrList(isBookmared: Bool = true) async throws -> (BookmarkListInquiryResponse, Int) {
        let router = BookmarkRouter.getBookmarks(isBookmared: isBookmared)
        return try await apiService.request(target: router)
    }
    
    func makeBookmark(id: Int) async throws -> Int {
        let router = BookmarkRouter.makeBookmark(id: id)
        return try await apiService.request(target: router)
    }
    
    func deleteBookmark(id: Int) async throws -> Int {
        let router = BookmarkRouter.deleteBookmark(id: id)
        return try await apiService.request(target: router)
    }
}
