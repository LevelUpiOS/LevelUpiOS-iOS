//
//  ExamResultComponent.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//  Copyright (c) 2024 ExamResult. All rights reserved.
//

import UIKit

import Carbon
import SnapKit

struct ExamResultItem: IdentifiableComponent {
    var questionNumber: Int
    var result: ExamResult
    var id: Int {
        return questionNumber
    }
    func renderContent() -> ExamResultComponent {
        return .init()
    }
    
    func render(in content: ExamResultComponent) {
        let questionNumberString = "\(questionNumber)."
        content.questionNumberLabel.text = questionNumberString
        content.questionLabel.text = result.question
        content.checkImage.image = .init(named: result.isCorrect ? "rightChecker" : "wrongChecker")
        content.explanationLabel.text = result.explaination
        content.answerImageView.image = .init(named: result.answer ? "ic_true" : "ic_false")
    }
}

final class ExamResultComponent: UIView {
    
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .designSystem(.white)
        return view
    }()
    
    let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._15)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    let checkImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.addTarget(self, action: #selector(bookmarkButtonTap), for: .touchUpInside)
        return button
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._15)
        label.textColor = .designSystem(.black)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.padding = .init(top: 5, left: 10, bottom: 5, right: 10)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .designSystem(.gray777)
        label.textColor = .designSystem(.black)
        label.font = .pretendard(.semiBold, ._10)
        label.text = "정답 및 해설"
        return label
    }()
    
    let answerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let explanationLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._13)
        label.textColor = .designSystem(.black)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func bookmarkButtonTap() {
        print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
    }

}

private extension ExamResultComponent {
    func setUI() {
        self.backgroundColor = .designSystem(.subOrange)
    }
    
    func setHierarchy() {
        self.addSubview(container)
        container.addSubview(questionNumberLabel)
        container.addSubview(checkImage)
        container.addSubview(bookmarkButton)
        container.addSubview(questionLabel)
        container.addSubview(infoLabel)
        container.addSubview(answerImageView)
        container.addSubview(explanationLabel)
    }
    
    func setLayout() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        questionNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        checkImage.snp.makeConstraints { make in
            make.center.equalTo(questionNumberLabel.snp.center)
            make.size.equalTo(50)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionNumberLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        answerImageView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(34)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(answerImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
