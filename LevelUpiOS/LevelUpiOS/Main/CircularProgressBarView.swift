//
//  CircularProgressBarView.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/8/24.
//

import UIKit

final class CircularProgressBarView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private let percentageLable: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._20)
        label.textAlignment = .center
        label.textColor = .designSystem(.black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addSubview(percentageLable)
        percentageLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("code based")
    }
    
    func createCircularPath() {
        // 원형 경로 설정
        let lineWidth: CGFloat = 15
        let radius: CGFloat = (min(frame.size.width, frame.size.height) - lineWidth) / 2
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0),
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )
        
        // 원형 레이어 설정
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 15
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.white.cgColor
        layer.addSublayer(circleLayer)
        
        // 프로그레스 레이어 설정
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 11
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = .designSystem(.mainOrange)
        layer.addSublayer(progressLayer)
    }
    
    // 프로그레스 바 업데이트 함수
    func setProgressWithAnimation(duration: TimeInterval, value: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        percentageLable.text = "\(Int(value*100))%"
        progressLayer.strokeEnd = value
        progressLayer.add(animation, forKey: "animateprogress")
    }
}
