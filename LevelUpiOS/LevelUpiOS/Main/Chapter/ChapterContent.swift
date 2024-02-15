//
//  ChapterContent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit


final class ChapterContent: UIControl {
    
    var onSelect: (() -> Void)?
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._18)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    let scoreOrGoQuestionButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.Main.icRightArrow
        config.baseForegroundColor = .black
        config.imagePlacement = .trailing
        config.imagePadding = 10
        let button = UIButton(configuration: config)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHirerachy()
        setLayout()
        setAddTarget()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHirerachy() {
        [checkImageView, chapterTitleLabel, scoreOrGoQuestionButton].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        checkImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(32)
            make.size.equalTo(30)
        }
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(checkImageView.snp.trailing).offset(10)
        }
        
        scoreOrGoQuestionButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.greaterThanOrEqualTo(chapterTitleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10).priority(.high)
        }
    }
    
    private func setAddTarget() {
        addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        scoreOrGoQuestionButton.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
    }
    
    @objc
    private func handleSelect() {
        onSelect?()
    }
    
    func configChapterContent(chapter: Chapter) {
        if case .solved = chapter.solveType {
            checkImageView.image = ImageLiterals.Main.checkedCircle
        } else {
            checkImageView.image = ImageLiterals.Main.uncheckedCircle
        }
        
        chapterTitleLabel.text = chapter.name
        
        if case .solved(let score) = chapter.solveType {
            scoreOrGoQuestionButton.setTitle("\(score.description)점", for: .normal)
        } else {
            scoreOrGoQuestionButton.setTitle("풀러가기", for: .normal)
        }
        
    }
}
