//
//  SplashViewController.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import UIKit

import SnapKit

final class SplashViewController: UIViewController {
    
    private let authService = AuthService(apiService: APIService())
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.light, ._15)
        label.text = "더 나은 iOS개발자를 위해"
        label.textColor = .designSystem(.mainOrange)
        label.textAlignment = .center
        return label
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, ._45)
        label.text = "레벨업iOS"
        label.textColor = .designSystem(.mainOrange)
        label.textAlignment = .center
        return label
    }()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "splashImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let corpLabel: UILabel = {
        let label = UILabel()
        label.text = "LevelUpCorp"
        label.font = .pretendard(.regular, ._18)
        label.textColor = .designSystem(.mainOrange)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            Task {
                if UserDefaultsManager.tokenKey == nil {
                    let cookie = try await self.authService.getCookie().decodedData.cookie
                    UserDefaultsManager.tokenKey = UserDefaultToken(cookie: cookie)
                }
                let mainVC = MainViewController(viewModel: MainViewModel(mainServiceManager: MainServiceManager(categoryService: CategoryService(apiService: APIService()), submissionService: SubmissionService(apiService: APIService()))))
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    
    private func setUI() {
        view.backgroundColor = .designSystem(.white)
    }
    
    private func setHierarchy() {
        view.addSubview(subTitleLabel)
        view.addSubview(mainTitleLabel)
        view.addSubview(mainImage)
        view.addSubview(corpLabel)
    }
    
    private func setLayout() {
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainTitleLabel.snp.top)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.trailing.equalTo(subTitleLabel.snp.trailing)
        }
        mainImage.snp.makeConstraints { make in
            make.leading.equalTo(mainTitleLabel.snp.trailing).offset(5)
            make.bottom.equalTo(mainTitleLabel.snp.bottom).offset(-10)
        }
        
        corpLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
}
