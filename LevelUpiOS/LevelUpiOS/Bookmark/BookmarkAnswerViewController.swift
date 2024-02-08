//
//  BookmarkAnswerViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/8/24.
//  Copyright (c) 2024 BookmarkAnswer. All rights reserved.
//

import UIKit

import SnapKit

final class BookmarkAnswerViewController: UIViewController {
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._15)
        label.textColor = .designSystem(.black)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "정답 및 해설"
        label.textAlignment = .center
        label.font = .pretendard(.regular, ._15)
        label.textColor = .designSystem(.white)
        label.backgroundColor = .designSystem(.gray777)
        return label
    }()
    
    private let isCorrectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._15)
        label.textColor = .designSystem(.black)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.designSystem(.white), for: .normal)
        button.backgroundColor = .designSystem(.mainOrange)
        button.titleLabel?.font = .pretendard(.semiBold, ._15)
        button.layer.cornerRadius = 20
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 컴포넌트 설정
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
        // MARK: - button의 addtarget설정
        setAddTarget()
        
        // MARK: - delegate설정
        setDelegate()

    }
    
    func configureUI(question: String, answer: String, isCorrect: Bool) {
        self.questionLabel.text = question
        self.answerLabel.text = answer
        self.isCorrectImage.image = UIImage(named: isCorrect ? "ic_true" : "ic_false")
    }
}

private extension BookmarkAnswerViewController {
    func setUI() {
        self.view.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.view.addSubview(questionLabel)
        self.view.addSubview(infoLabel)
        self.view.addSubview(isCorrectImage)
        self.view.addSubview(answerLabel)
        self.view.addSubview(closeButton)
    }
    
    func setLayout() {
        questionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        isCorrectImage.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(35)
        }
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(isCorrectImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(closeButton.snp.top).offset(-20)
        }
        closeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
