//
//  UIFont+.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

extension UIFont {
    
    public class func pretendard(_ weight: Font.Weight, _ size: Font.Size) -> UIFont {
        let font = Font.PretendardFont(name: .pretendard, weight: weight)
        return ._font(name: font.name, size: size.rawValue)
    }
    
    private static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
