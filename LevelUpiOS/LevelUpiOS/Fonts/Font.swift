//
//  Font.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

public enum Font {
    
    public enum Name: String {
        case pretendard = "Pretendard"
    }
    
    public enum Size: CGFloat {
        case _10 = 10
        case _13 = 13
        case _15 = 15
        case _18 = 18
        case _20 = 20
        case _30 = 30
    }

    public enum Weight: String {
        case regular = "Regular"
        case semiBold = "SemiBold"
        case bold = "Bold"
    }

    public struct PretendardFont {
        private let _name: Name
        private let _weight: Weight

        init(name: Name, weight: Weight) {
            self._name = name
            self._weight = weight
        }

        var name: String {
            "\(_name.rawValue)-\(_weight.rawValue)"
        }

        var `extension`: String {
            "ttf"
        }
    }
    

    public static func registerFonts() {
        pretendardFonts.forEach { font in
            Font.registerFont(fontName: font.name, fontExtension: font.extension)
        }
    }
}

extension Font {
    static var pretendardFonts: [PretendardFont] {
        [
            PretendardFont(name: .pretendard, weight: .regular),
            PretendardFont(name: .pretendard, weight: .semiBold),
            PretendardFont(name: .pretendard, weight: .bold)
        ]
    }

   static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle(identifier: "com.levelup.LevelUpiOS")?.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

