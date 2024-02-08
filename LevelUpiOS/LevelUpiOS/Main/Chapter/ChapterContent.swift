//
//  ChapterContent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit


final class ChapterContent: UIView {
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._18)
        label.textColor = .black
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
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(32)
        }
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkImageView)
            make.leading.equalTo(checkImageView.snp.trailing).offset(10)
        }
        
        scoreOrGoQuestionButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(chapterTitleLabel.snp.trailing).offset(10)
            make.centerY.equalTo(chapterTitleLabel)
            make.trailing.equalToSuperview().inset(32).priority(.high)
        }
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