//
//  ReviewBoxView.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

final class ReviewBoxView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "렙업노트"
        label.font = .pretendard(.bold, ._20)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "틀린 문제만 모아놨어요"
        label.font = .pretendard(.regular, ._13)
        return label
    }()
    
    private let reviewButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainOrange
        config.baseForegroundColor = .white
        config.title = "복습하러가기"
        config.titlePadding = 14
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHirerachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    private func setHirerachy() {
        [titleLabel, subtitleLabel, reviewButton]
            .forEach {
                self.addSubview($0)
            }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(21)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
        
        reviewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(7)
        }
    }

}
