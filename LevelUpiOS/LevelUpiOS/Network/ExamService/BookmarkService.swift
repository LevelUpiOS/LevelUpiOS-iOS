//
//  BookmarkService.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation

final class BookmarkService {
    let apiService = APIService()
    
    func getBookmakrList() async throws -> (BookmarkListInquiryResponse, Int) {
        let router = BookmarkRouter.getBookmarks
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
