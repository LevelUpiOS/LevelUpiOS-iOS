//
//  TopicHeaderContent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit


final class TopicHeaderContent: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, ._20)
        label.textColor = .black
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._15)
        label.textColor = .black
        return label
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
        
    }
    
    private func setHirerachy() {
        [titleLabel, subtitleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(33)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(titleLabel)
        }
        
    }
    
    func configContent(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
