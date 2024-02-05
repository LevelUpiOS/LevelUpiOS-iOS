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
    
    var id: String {
        return question
    }
    
    func renderContent() -> BookmarkComponent {
        .init()
    }
    
    func render(in content: BookmarkComponent) {
        content.questionLabel.text = question
        content.sourceLabel.text = source
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: bounds.width, height: bounds.height)
    }
    
}

final class BookmarkComponent: UIView {
    
    let questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "OX퀴즈"
        label.textColor = .designSystem(.mainOrange)
        label.backgroundColor = .designSystem(.subOrange)
        return label
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
        self.backgroundColor = .red
        self.addSubview(sideDecoratedView)
        self.addSubview(questionTypeLabel)
        self.addSubview(questionLabel)
        self.addSubview(sourceLabel)
 
        questionTypeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionTypeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        sideDecoratedView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
