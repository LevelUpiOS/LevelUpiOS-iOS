//
//  ViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, ._30)
        label.textColor = .designSystem(.white)
        label.text = "테스트입니다"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.black)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testLabel)
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }


}
