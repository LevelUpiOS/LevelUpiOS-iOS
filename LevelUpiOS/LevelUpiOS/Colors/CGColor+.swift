//
//  CGColor+.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

extension CGColor {
    static func designSystem(_ color: Palette) -> CGColor? {
        UIColor(named: color.rawValue)?.cgColor
    }
}
