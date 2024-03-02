//
//  UIAlertController+.swift
//  LevelUpiOS
//
//  Created by uiskim on 3/2/24.
//

import UIKit

extension UIAlertController {
    static func subminQuizAlert(completionHandler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "답안제출",
                                      message: "답안 내용은 분석을 위해 저장됩니다, 결과를 확인하세요",
                                      preferredStyle: .alert)
        let confirm = UIAlertAction(title: "결과보러가기", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(confirm)
        return alert
    }
}

extension UIAlertController {
    static func reportAlert(completionHandler: @escaping (String?) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "문제관련 문의",
                                      message: "문제의 해설이나 정답 혹은 문제수정에 대한 의견을 보내주시면 검토후 수정하겠습니다:)",
                                      preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "문제에 대한 의견을 말씀해주세요"
        }
        let confirm = UIAlertAction(title: "보내기", style: .default) { _ in
            completionHandler(alert.textFields?[0].text)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        return alert
    }
}


