//
//  UIColor+.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

extension UIColor {
    static func designSystem(_ color: Palette) -> UIColor? {
        UIColor(named: color.rawValue)
    }
}
