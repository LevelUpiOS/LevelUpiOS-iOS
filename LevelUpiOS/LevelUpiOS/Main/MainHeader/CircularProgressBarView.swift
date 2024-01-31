//
//  CircularProgressBarView.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit


final class CircularProgressView: UIView {
    
    private var lineWidth: CGFloat = 3
    
    private let perecentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .pretendard(.semiBold, ._20)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHirerachy()
        setLayout()
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        
        bezierPath.addArc(
            withCenter: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.midX - ((lineWidth - 1) / 2),
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true)
        bezierPath.lineWidth = 1
        UIColor.clear.set()
        bezierPath.stroke()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("code based")
    }
    
    private func setHirerachy() {
        self.addSubview(perecentLabel)
    }
    
    private func setLayout() {
        perecentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setProgress(_ rect: CGRect, value: CGFloat) {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let bezierPath = UIBezierPath()
        let radius = rect.midX - ((lineWidth - 1) / 2)
        let endStart: CGFloat = (.pi * 2) * value
        let endAngle: CGFloat = endStart - (.pi / 2)
        
        bezierPath.addArc(
            withCenter: CGPoint(
                x: rect.midX,
                y: rect.midY
            ),
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: endAngle,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round
                
        shapeLayer.strokeColor = .designSystem(.mainOrange)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
}

