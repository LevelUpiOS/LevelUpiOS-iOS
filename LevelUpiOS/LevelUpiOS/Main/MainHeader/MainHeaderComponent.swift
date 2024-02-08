//
//  MainHeaderComponent.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit

import Carbon

struct MainHeaderComponent: IdentifiableComponent {
    
    private enum Size {
        static let screenHeight = UIScreen.main.bounds.height
        static let headerHeight = screenHeight * (330/875)
    }
    
    var totalCount: Int
    var solvedCount: Int
    
    var id: String {
        return UUID().uuidString
    }
    
    init(totalCount: Int, solvedCount: Int) {
        self.totalCount = totalCount
        self.solvedCount = solvedCount
    }
    
    func render(in content: MainHeaderContent) {
        content.configHeaderContent(totalCount: totalCount, solvedCount: solvedCount)
    }
    
    func renderContent() -> MainHeaderContent {
        return MainHeaderContent()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: Size.headerHeight)
    }
    
}

final class MainHeaderContent: UIView {
    
    private enum Size {
        static let screenHeight = UIScreen.main.bounds.height
        static let backgroundImageheight = screenHeight * (200/875)
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.Main.mainBackground
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, ._30)
        label.text = "레벨업 iOS"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, ._13)
        label.text = "한 주제당 10개의 문제가 준비되어 있어요!"
        return label
    }()
    
    private let progressBoxView: ProgressBoxView = {
       let view = ProgressBoxView()
        view.layer.shadowColor = .designSystem(.black)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private let reviewBoxView: ReviewBoxView = {
        let view = ReviewBoxView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowRadius = 5
        return view
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
        [backgroundImageView, titleLabel, subtitleLabel, progressBoxView, reviewBoxView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Size.backgroundImageheight)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(106)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
        
        progressBoxView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(17)
            make.leading.equalTo(subtitleLabel)
            make.width.equalTo(147)
            make.height.equalTo(progressBoxView.snp.width)
                .multipliedBy(137.0/147.0)
        }
        
        reviewBoxView.snp.makeConstraints { make in
            make.leading.equalTo(progressBoxView.snp.trailing).offset(13)
            make.trailing.equalToSuperview().inset(32)
            make.top.equalTo(progressBoxView)
            make.bottom.equalTo(progressBoxView)
        }
    }
    
    func configHeaderContent(totalCount: Int, solvedCount: Int) {
        progressBoxView.configProgressView(
            totalCount: totalCount,
            solvedCount: solvedCount
        )
    }
}