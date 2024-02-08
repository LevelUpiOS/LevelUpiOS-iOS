//
//  ProgressBoxView.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

final class ProgressBoxView: UIView {

    let progressBarView = CircularProgressBarView(frame: .init(x: 0, y: 0, width: 85, height: 85))
    
    private let completeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._13)
        label.numberOfLines = 1
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
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
    
    private func setHirerachy() {
        [progressBarView, completeCountLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        progressBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(31)
            make.top.equalToSuperview().inset(14)
        }
        
        completeCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(progressBarView)
            make.top.equalTo(progressBarView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(14)
        }
    }
    
    func configProgressView(totalCount: Int, solvedCount: Int) {
        let percent = CGFloat(solvedCount) / CGFloat(totalCount) * 100
        completeCountLabel.text = "\(totalCount)개 중에 \(solvedCount)개 완료"
        progressBarView.setProgressWithAnimation(duration: 1.5, value: 0.4)
    }
}