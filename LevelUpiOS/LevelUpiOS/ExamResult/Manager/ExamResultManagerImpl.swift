//
//  ExamResultManagerImpl.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/15/24.
//

import Foundation
import Combine

protocol ExamResultManager {
    func getBookmark(id: Int) async throws
    func deleteBookmark(id: Int) async throws
}

final class ExamResultManagerImpl: ExamResultManager {
    
    let bookmarkService: BookmarkService
    
    init(bookmarkService: BookmarkService) {
        self.bookmarkService = bookmarkService
    }
    
    func getBookmark(id: Int) async throws {
        _ = try await bookmarkService.makeBookmark(id: id)
    }
    
    func deleteBookmark(id: Int) async throws {
        _ = try await bookmarkService.deleteBookmark(id: id)
    }
}
