//
//  ProblemSolvingViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 1/31/24.
//  Copyright (c) 2024 ProblemSolving. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class ProblemSolvingViewController: UIViewController {
    
    let viewModel = ProblemSolvingViewModel()
    
    var cancelBag = Set<AnyCancellable>()
    let userAnswerSubject = PassthroughSubject<Bool, Never>()
    let viewwillAppearSubject = PassthroughSubject<Void, Never>()
    
    let problemSolvingProgressBar: UIProgressView = {
        let pb = UIProgressView(progressViewStyle: .bar)
        pb.trackTintColor = .designSystem(.background)
        pb.progressTintColor = .designSystem(.mainOrange)
        return pb
    }()
    
    let quizNumberLable: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._30)
        label.textColor = .designSystem(.black)
        label.textAlignment = .center
        label.text = "Quiz1"
        return label
    }()
    
    let quizDescription: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, ._18)
        label.textColor = .designSystem(.black)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let quizBackgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "question_background"))
        view.contentMode = .scaleToFill
        view.layer.shadowColor = .designSystem(.black)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.clipsToBounds = true
        return view
    }()
    
    let charactorImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_orange_bird"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let trueButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_true"), for: .normal)
        button.backgroundColor = .designSystem(.white)
        button.layer.cornerRadius = 30
        button.layer.cornerRadius = 30
        button.layer.shadowColor = .designSystem(.black)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.layer.shadowRadius = 5
        return button
    }()
    
    let falseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_false"), for: .normal)
        button.backgroundColor = .designSystem(.white)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = .designSystem(.black)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.layer.shadowRadius = 5
        return button
    }()
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewwillAppearSubject.send(())
    }
}

private extension ProblemSolvingViewController {
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubview(problemSolvingProgressBar)
        self.view.addSubview(quizNumberLable)
        self.view.addSubview(quizBackgroundView)
        self.view.addSubview(quizDescription)
        self.view.addSubview(charactorImage)
        self.view.addSubview(trueButton)
        self.view.addSubview(falseButton)
    }
    
    func setLayout() {
        problemSolvingProgressBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(6)
        }
        
        quizNumberLable.snp.makeConstraints { make in
            make.top.equalTo(problemSolvingProgressBar.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        quizBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(quizNumberLable.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(self.quizBackgroundView.snp.width)
        }
        
        quizDescription.snp.makeConstraints { make in
            make.top.equalTo(quizBackgroundView.snp.top).offset(80)
            make.leading.equalTo(quizBackgroundView.snp.leading).offset(40)
            make.trailing.equalTo(quizBackgroundView.snp.trailing).offset(-40)
        }
        
        charactorImage.snp.makeConstraints { make in
            make.top.equalTo(quizBackgroundView.snp.centerY)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(quizBackgroundView.snp.bottom).offset(20)
        }
        
        trueButton.snp.makeConstraints { make in
            make.top.equalTo(quizBackgroundView.snp.bottom).offset(40)
            make.leading.equalTo(quizBackgroundView.snp.leading)
            make.width.equalTo(falseButton.snp.width)
            make.height.equalTo(self.trueButton.snp.width)
            make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).offset(-30)
        }
        
        falseButton.snp.makeConstraints { make in
            make.top.equalTo(trueButton.snp.top)
            make.trailing.equalTo(quizBackgroundView.snp.trailing)
            make.leading.equalTo(trueButton.snp.trailing).offset(20)
            make.width.equalTo(trueButton.snp.width)
            make.height.equalTo(self.falseButton.snp.width)
            make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    func setAddTarget() {
        trueButton.addTarget(self, action: #selector(trueButtonTapped), for: .touchUpInside)
        falseButton.addTarget(self, action: #selector(falseButtonTapped), for: .touchUpInside)
    }
    
    @objc func trueButtonTapped() {
        userAnswerSubject.send(true)
    }
    
    @objc func falseButtonTapped() {
        userAnswerSubject.send(false)
    }
    
    func bind() {
        let output = viewModel.transform(from: .init(userAnswerSubject: userAnswerSubject,
                                                     viewwillAppearSubject: viewwillAppearSubject))
        output.viewwillAppearPublisher
            .sink { [weak self] subject, description in
                self?.title = subject
                self?.quizDescription.text = description
                self?.problemSolvingProgressBar.setProgress(0, animated: true)
            }
            .store(in: &cancelBag)
        
        output.userAnswerPublisher
            .sink { [weak self] state in
                self?.quizNumberLable.text = "Quiz\(state.quizIndex)"
                self?.quizDescription.text = state.description
                self?.problemSolvingProgressBar.setProgress(state.percentage, animated: true)
            }
            .store(in: &cancelBag)
        
        output.lastAnwerPublisher
            .sink { [weak self] _ in
                let alert = UIAlertController.subminQuizAlert { 
                    self?.view.isUserInteractionEnabled = false
                    print("제출했어요~")
                }
                self?.present(alert, animated: true)
            }
            .store(in: &cancelBag)
    }
}

extension UIAlertController {
    static func subminQuizAlert(completionHandler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "답안제출",
                                      message: "답안 내용은 분석을 위해 저장됩니다, 결과를 확인하세요",
                                      preferredStyle: .alert)
        let confirm = UIAlertAction(title: "결과보러가기", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(confirm)
        return alert
    }
}
