//
//  ProgressBoxView.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

final class ProgressBoxView: UIView {

    let progressBarView = CircularProgressView()
    
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
        self.layer.masksToBounds = true
    }
    
    private func setHirerachy() {
        [progressBarView, completeCountLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        progressBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(14)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        completeCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBarView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(14)
        }
    }
    
    func configProgressView(totalCount: Int, solvedCount: Int) {
        let percent = CGFloat(solvedCount) / CGFloat(totalCount) * 100
        completeCountLabel.text = "\(totalCount)개 중에 \(solvedCount)개 완료"
        progressBarView.setProgress(
            progressBarView.bounds,
            value: percent
        )
    }
}
