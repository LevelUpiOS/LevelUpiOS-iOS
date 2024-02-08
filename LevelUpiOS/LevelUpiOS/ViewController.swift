//
//  ViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let progressBarView: CircularProgressBarView = {
        let view = CircularProgressBarView(frame: .init(x: 0, y: 0, width: 85, height: 85))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.white)
        view.addSubview(progressBarView)
        progressBarView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        progressBarView.setProgressWithAnimation(duration: 1, value: 0.6)
        
        print(Config.baseURL)
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
    }
}
