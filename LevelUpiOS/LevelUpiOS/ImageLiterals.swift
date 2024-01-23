//
//  ImageLiteral.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/23/24.
//

import UIKit

enum ImageLiterals {
    
    enum Main {
        static var mainBackground: UIImage { .load(named: "main_background") }
        static var checkedCircle: UIImage { .load(named: "ic_checked") }
        static var uncheckedCircle: UIImage { .load(named: "ic_unchecked") }
    }
    
    enum Question {
        static var questionBackground: UIImage { .load(named: "question_background") }
        static var trueAnswer: UIImage { .load(named: "ic_true") }
        static var falseAnswer: UIImage { .load(named: "ic_false") }
        static var orangeBird: UIImage { .load(named: "ic_orange_bird") }
    }
    
}


extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
}
