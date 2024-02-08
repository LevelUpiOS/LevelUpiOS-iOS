//
//  ChapterComponent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

import Carbon

struct ChapterComponent: IdentifiableComponent {
    
    let chapter: Chapter
    
    var id: String {
        return chapter.name
    }
    
    init(chapter: Chapter) {
        self.chapter = chapter
    }
    
    func renderContent() -> ChapterContent {
        return ChapterContent()
    }
    
    func render(in content: ChapterContent) {
        content.configChapterContent(chapter: chapter)
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 64)
    }
    
}
