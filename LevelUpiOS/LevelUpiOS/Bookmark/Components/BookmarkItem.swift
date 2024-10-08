//
//  BookmarkItem.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon
import SnapKit

struct BookmarkItem: IdentifiableComponent {
    var question: String
    var source: String
    var tap: (()->Void)
    var bookmarkTap: (()-> Void)
    var reportTap: (() -> Void)
    
    var id: String {
        return question
    }
    
    func renderContent() -> BookmarkComponent {
        .init()
    }
    
    func render(in content: BookmarkComponent) {
        content.questionLabel.text = question
        content.sourceLabel.text = source
        content.tapped = tap
        content.bookmarkTapped = bookmarkTap
        content.reportTapped = reportTap
    }
}

final class BookmarkComponent: UIView {
    
    var tapped: (() -> Void)?
    var bookmarkTapped: (() -> Void)?
    var reportTapped: (() -> Void)?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.7
        view.layer.borderColor = .designSystem(.grayC4)
        view.clipsToBounds = true
        return view
    }()
    
    let questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "OX퀴즈"
        label.font = .pretendard(.regular, ._13)
        label.textColor = .designSystem(.mainOrange)
        label.backgroundColor = .designSystem(.subOrange)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = .designSystem(.mainOrange)
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
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
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._13)
        label.textColor = .designSystem(.gray777)
        label.textAlignment = .left
        return label
    }()
    
    let sideDecoratedView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.subOrange)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(containerView)
        containerView.addSubview(sideDecoratedView)
        containerView.addSubview(questionTypeLabel)
        containerView.addSubview(questionLabel)
        containerView.addSubview(sourceLabel)
        containerView.addSubview(bookmarkButton)
        containerView.addSubview(reportButton)


        questionTypeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalTo(sideDecoratedView.snp.leading).offset(-10)
            make.size.equalTo(30)
        }

        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(bookmarkButton.snp.top)
            make.size.equalTo(30)
            make.trailing.equalTo(bookmarkButton.snp.leading)
        }

        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionTypeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(sideDecoratedView.snp.leading).offset(-10)
            make.bottom.equalTo(sourceLabel.snp.top).offset(-20)
        }

        sourceLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        sideDecoratedView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        let bookmarkCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(bookmarkCellTapped))
        containerView.addGestureRecognizer(bookmarkCellTapGesture)
    }
    
    @objc func bookmarkCellTapped() {
        self.tapped?()
    }
    
    @objc func bookmarkButtonTapped() {
        self.bookmarkTapped?()
    }
    
    @objc func reportButtonTap() {
        self.reportTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
