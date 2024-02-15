//
//  SplashViewController.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let authService = AuthService(apiService: APIService())

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Task {
                if UserDefaultsManager.tokenKey == nil {
                    let cookie = try await self.authService.getCookie().decodedData.cookie
                    UserDefaultsManager.tokenKey = UserDefaultToken(cookie: cookie)
                }
                let mainVC = MainViewController(viewModel: MainViewModelImpl(mainServiceManager: MainServiceManager(categoryService: CategoryService(apiService: APIService()), submissionService: SubmissionService(apiService: APIService()))))
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    
    private func setUI() {
        view.backgroundColor = .designSystem(.mainOrange)
    }
    
    private func setHierarchy() {
        
    }
    
    private func setLayout() {
        
    }
}
