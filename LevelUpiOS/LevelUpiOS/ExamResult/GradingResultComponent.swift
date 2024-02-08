//
//  GradingResultComponent.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//

import UIKit

import Carbon
import SnapKit

struct GradingResultItem: IdentifiableComponent {
    let grade: Int
    var id: Int {
        return grade
    }
    func renderContent() -> GradingResultComponent {
        return .init()
    }
    
    func render(in content: GradingResultComponent) {
        content.gradeLabel.text = "\(grade)점"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(width: UIScreen().bounds.width, height: 130)
    }
}

final class GradingResultComponent: UIView {
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._30)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    private let charactorImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_orange_bird"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._13)
        label.numberOfLines = 2
        label.textColor = .designSystem(.mainOrange)
        label.textAlignment = .center
        label.text = "틀린문제 혹은 헷갈리는 문제는\n북마크를 통한 복습노트를 제공해드려요"
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.subOrange)
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .designSystem(.white)
        self.addSubview(gradeLabel)
        self.addSubview(containerView)
        self.addSubview(charactorImage)
        containerView.addSubview(infoLabel)
        
        gradeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        charactorImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(gradeLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        infoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
