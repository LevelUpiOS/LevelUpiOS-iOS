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
    var questionIndex: Int
    var result: ExamResultDTO.ExamResultPerQuiz
    var bookmarkTapped: (Int?) -> Void
    var reportTapped: (Int?) -> Void
    
    var id: Int {
        return questionIndex
    }
    func renderContent() -> ExamResultComponent {
        return .init()
    }
    
    func render(in content: ExamResultComponent) {
        let questionNumberString = "\(questionIndex)."
        content.questionNumberLabel.text = questionNumberString
        content.questionLabel.text = result.description
        content.checkImage.image = .init(named: result.isCorrect ? "rightChecker" : "wrongChecker")
        content.explanationLabel.text = result.explanation
        content.answerImageView.image = .init(named: result.answer ? "ic_true" : "ic_false")
        content.bookmarkButton.setImage(.init(systemName: result.bookmark ? "bookmark.fill" : "bookmark"), for: .normal)
        content.questionId = result.questionId
        content.bookmarkTapped = bookmarkTapped
        content.reportTapped = reportTapped
    }
}

final class ExamResultComponent: UIView {
    
    var bookmarkTapped: ((Int?) -> Void)?
    var reportTapped: ((Int?) -> Void)?
    
    var questionId: Int?
    
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
        button.tintColor = .designSystem(.mainOrange)
        button.addTarget(self, action: #selector(bookmarkButtonTap), for: .touchUpInside)
        return button
    }()
    
    lazy var reportButton: UIButton = {
        let button = UIButton()
        button.tintColor = .designSystem(.mainOrange)
        button.setImage(UIImage(systemName: "light.beacon.max"), for: .normal)
        button.addTarget(self, action: #selector(reportButtonTap), for: .touchUpInside)
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
        label.backgroundColor = .designSystem(.subOrange)
        label.textColor = .designSystem(.mainOrange)
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
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func bookmarkButtonTap() {
        self.bookmarkTapped?(self.questionId)
    }
    
    @objc func reportButtonTap() {
        self.reportTapped?(self.questionId)
    }

}

private extension ExamResultComponent {
    func setUI() {
        self.backgroundColor = .designSystem(.subOrange)
    }
    
    func setHierarchy() {
        self.addSubview(container)
        questionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        container.addSubview(questionNumberLabel)
        container.addSubview(checkImage)
        container.addSubview(bookmarkButton)
        container.addSubview(reportButton)
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
            make.height.equalTo(30)
        }
        
        checkImage.snp.makeConstraints { make in
            make.centerX.equalTo(questionNumberLabel.snp.centerX)
            make.centerY.equalTo(questionNumberLabel.snp.centerY)
            make.size.equalTo(50)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(bookmarkButton.snp.top)
            make.size.equalTo(30)
            make.trailing.equalTo(bookmarkButton.snp.leading)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionNumberLabel.snp.bottom).offset(20)
            make.bottom.equalTo(infoLabel.snp.top).offset(-15)
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
}
