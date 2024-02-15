//
//  ExamResultViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//  Copyright (c) 2024 ExamResult. All rights reserved.
//

import UIKit
import Combine

import Carbon
import SnapKit

final class ExamResultViewController: UIViewController {
    
    let bookmarkTap = PassthroughSubject<(Int, Int?), Never>()
    let viewwillAppearSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    let resultView: UITableView = {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        tb.backgroundColor = .designSystem(.white)
        return tb
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("홈으로가기", for: .normal)
        button.addTarget(self, action: #selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        return button
    }()

    
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    let viewModel: ExamResultViewModel
    init(viewModel: ExamResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        renderer.target = resultView
        setUI()
        setHierarchy()
        setLayout()

        let output = viewModel.transform(from: .init(bookmarkTap: self.bookmarkTap,
                                                     viewWillAppearSubject: self.viewwillAppearSubject))
        
        output.reloadPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.render(data: data)
            }
            .store(in: &cancelBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
        self.viewwillAppearSubject.send(())
    }
    
    
    func render(data: ExamResultDTO) {
        self.renderer.render {
            GradingResultItem(grade: data.score)
            Group(of: data.results.enumerated()) { index, result in
                ExamResultItem(questionIndex: index+1, result: result) { questionId in
                    self.bookmarkTap.send((index, questionId))
                }
            }
        }
    }
    
    @objc func callMethod() {
        guard let controllers = self.navigationController?.viewControllers else { return }
        for vc in controllers {
            if vc is MainViewController {
                self.navigationController?.popToViewController(vc as! MainViewController, animated: true)
            }
        }
    }
}

private extension ExamResultViewController {
    func setUI() {
        self.title = "채점결과"
        view.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        view.addSubview(resultView)
    }
    
    func setLayout() {
        resultView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
