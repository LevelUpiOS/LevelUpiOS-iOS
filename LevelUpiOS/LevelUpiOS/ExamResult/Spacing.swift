//
//  Spacing.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//

import UIKit
import Carbon

struct Spacing: Component {
    var height: CGFloat

    init(_ height: CGFloat) {
        self.height = height
    }

    func renderContent() -> UIView {
        UIView()
    }

    func render(in content: UIView) {}

    func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: height)
    }
}

