//
//  ChapterComponent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

import Carbon

struct ChapterComponent: IdentifiableComponent {
    
    private let chapter: Chapter
    
    var onSelect: () -> Void
    
    var id: String {
        return chapter.name
    }
    
    init(chapter: Chapter, onSelect: @escaping () -> Void) {
        self.chapter = chapter
        self.onSelect = onSelect
    }
    
    func renderContent() -> ChapterContent {
        return ChapterContent()
    }
    
    func render(in content: ChapterContent) {
        content.configChapterContent(chapter: chapter)
        content.onSelect = onSelect
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 64)
    }
    
}
