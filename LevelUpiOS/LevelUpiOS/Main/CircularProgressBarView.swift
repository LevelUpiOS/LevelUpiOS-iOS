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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("code based")
    }
    
    private func createCircularPath() {
        // 원형 경로 설정
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0),
            radius: (frame.size.width - 1.5) / 2,
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
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        layer.addSublayer(circleLayer)
        
        // 프로그레스 레이어 설정
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 15
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.orange.cgColor
        layer.addSublayer(progressLayer)
    }
    
    // 프로그레스 바 업데이트 함수
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
}
