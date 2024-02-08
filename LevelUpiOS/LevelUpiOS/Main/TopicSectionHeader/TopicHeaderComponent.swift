//
//  TopicHeaderComponent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import SwiftUI
import Carbon


struct TopicHeaderComponent: Component {
    
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    func renderContent() -> TopicHeaderContent {
        return TopicHeaderContent()
    }
    
    func render(in content: TopicHeaderContent) {
        content.configContent(
            title: title,
            subtitle: subtitle
        )
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: 64)
    }
    
}
