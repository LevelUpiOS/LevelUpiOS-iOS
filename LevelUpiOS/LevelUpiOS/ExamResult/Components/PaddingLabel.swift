//
//  PaddingLabel.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//

import UIKit

final class PaddingLabel: UILabel {
    var padding: UIEdgeInsets
    
    @IBInspectable
    var left: CGFloat {
        get {
            self.padding.left
        }
        set {
            self.padding.left = newValue
        }
    }
    
    @IBInspectable
    var right: CGFloat {
        get {
            self.padding.right
        }
        set {
            self.padding.right = newValue
        }
    }
    
    @IBInspectable
    var top: CGFloat {
        get {
            self.padding.top
        }
        set {
            self.padding.top = newValue
        }
    }
    
    @IBInspectable
    var bottom: CGFloat {
        get {
            self.padding.bottom
        }
        set {
            self.padding.bottom = newValue
        }
    }

    override init(frame: CGRect) {
        self.padding = .zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.padding = .zero
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    convenience init(inset: UIEdgeInsets) {
        self.init(frame: .zero)
        self.padding = inset
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom
        return size
    }
}

