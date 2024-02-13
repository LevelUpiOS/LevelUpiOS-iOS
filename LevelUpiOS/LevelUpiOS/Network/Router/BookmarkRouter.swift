//
//  BookmarkRouter.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/11/24.
//

import Foundation
import Alamofire

enum BookmarkRouter {
    case getBookmarks(isBookmared: Bool = true)
    case makeBookmark(id: Int)
    case deleteBookmark(id: Int)
}

extension BookmarkRouter: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getBookmarks:
            return .get
        case .makeBookmark:
            return .post
        case .deleteBookmark:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getBookmarks:
            return "/v1/questions"
        case .makeBookmark(let id):
            return "/v1/questions/\(id)/bookmark"
        case .deleteBookmark(let id):
            return "/v1/questions/\(id)/bookmark"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getBookmarks(let isBookmared):
            struct GetBookmarkRequest: Encodable {
                var bookmarkOnly: Bool
            }
            return .requestQuery(GetBookmarkRequest(bookmarkOnly: isBookmared))
        case .makeBookmark, .deleteBookmark:
            return .requestPlain
        }
    }
}
