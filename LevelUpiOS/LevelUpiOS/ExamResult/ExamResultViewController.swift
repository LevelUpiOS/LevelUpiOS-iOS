//
//  ExamResultViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/1/24.
//  Copyright (c) 2024 ExamResult. All rights reserved.
//

import UIKit

import Carbon
import SnapKit

final class ExamResultViewController: UIViewController {
    let resultView: UITableView = {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        tb.backgroundColor = .designSystem(.white)
        return tb
    }()
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    var data: ExamResultDTO
    
    init(data: ExamResultDTO) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
  

        renderer.target = resultView

        // MARK: - 컴포넌트 설정
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
        // MARK: - button의 addtarget설정
        setAddTarget()
        
        // MARK: - delegate설정
        setDelegate()
        render()
    }
    
    func render() {
        renderer.render {
            GradingResultItem(grade: data.score)
            Group(of: data.results.enumerated()) { index, result in
                ExamResultItem(questionNumber: index+1, result: result)
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
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
