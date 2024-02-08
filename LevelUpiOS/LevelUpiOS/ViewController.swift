//
//  ViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2024/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
//    var cancelBag = Set<AnyCancellable>()
//    let apiService = APIRequestLoader()
//    
//    let buttonTapSubject = PassthroughSubject<Void, Never>()
//    
//    let button = UIButton()
//    
//    private let progressBarView: CircularProgressBarView = {
//        let view = CircularProgressBarView(frame: .init(x: 0, y: 0, width: 85, height: 85))
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .designSystem(.white)
//        view.addSubview(progressBarView)
//        view.addSubview(button)
//        button.setTitle("테스트", for: .normal)
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
//        button.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(200)
//        }
////        progressBarView.snp.makeConstraints { make in
////            make.center.equalToSuperview()
////        }
////        progressBarView.setProgressWithAnimation(duration: 1, value: 0.6)
//        
//        print(Config.baseURL)
//        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
//        
//        buttonTapSubject.sink { _ in
//            self.getCategoryPublisher()
//                .asDriver()
//                .sink { result in
//                    switch result {
//                    case .success(let success):
//                        print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
//                        print(success)
//                    case .failure(let failure):
//                        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
//                        print(failure)
//                    }
//                }
//                .store(in: &self.cancelBag)
//        }
//        .store(in: &cancelBag)
//
//    }
//    
//    func getCategoryPublisher() -> AnyPublisher<Result<(CategoryDatas, Int), LevelUpError>, Never> {
//        return apiService.request(target: CategoryRouter.getCategory)
//    }
//    
//    @objc func tap() {
//        self.buttonTapSubject.send(())
//    }
}
