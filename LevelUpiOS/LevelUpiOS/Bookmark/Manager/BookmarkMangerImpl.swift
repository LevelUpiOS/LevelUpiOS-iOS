//
//  BookmarkMangerImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/15/24.
//

import Foundation
import Combine

protocol BookmarkManger {
    func getBookmakrList(isBookmared: Bool) async throws -> [BookmarkDTO]
    func makeBookmark(id: Int) async throws
    func deleteBookmark(id: Int) async throws
}

final class BookmarkMangerImpl: BookmarkManger {
    
    private let bookmarkService: BookmarkService
    init(bookmarkService: BookmarkService) {
        self.bookmarkService = bookmarkService
    }
    
    func getBookmakrList(isBookmared: Bool) async throws -> [BookmarkDTO] {
        let bookmarkResponse = try await self.bookmarkService.getBookmakrList(isBookmared: isBookmared)
        return bookmarkResponse.0.toDTO
    }
    
    func makeBookmark(id: Int) async throws {
        _ = try await bookmarkService.makeBookmark(id: id)
    }
    
    func deleteBookmark(id: Int) async throws {
        _ = try await bookmarkService.deleteBookmark(id: id)
    }
    
    
}
