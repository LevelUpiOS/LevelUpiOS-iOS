//
//  BookmarkViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/5/24.
//  Copyright (c) 2024 Bookmark. All rights reserved.
//

import UIKit
import Combine

import Carbon
import SnapKit

final class BookmarkViewController: UIViewController {
    
    let viewModel = BookmarkViewModel()
    
    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let bookmarkTap = PassthroughSubject<(index: Int, id: Int), Never>()
    let cellTap = PassthroughSubject<Int, Never>()
    var cancelBag = Set<AnyCancellable>()
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.tintColor = .designSystem(.black)
        button.sizeToFit()
        return button
    }()
    let bookmarkView = UITableView(frame: .zero, style: .grouped)
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setHierarchy()
        setLayout()
        render(datas: [])
        let output = viewModel.transform(from: .init(viewWillAppearSubject: self.viewWillAppearSubject,
                                                     bookmarkTap: self.bookmarkTap,
                                                     cellTap: self.cellTap))
        output.reloadPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] datas in
                self?.render(datas: datas)
            }
            .store(in: &cancelBag)
        
        output.presentDetailSheetPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.presentDetail(data: data)
            }
            .store(in: &cancelBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
        self.viewWillAppearSubject.send(())
    }
    
    func render(datas: [BookmarkDTO]) {
        renderer.render {
            if datas.isEmpty {
                BookmarkEmptyItem()
            } else {
                Group(of: datas.enumerated()) { index, bookmark in
                    BookmarkItem(question: bookmark.question, source: bookmark.source) {
                        self.cellTap.send(index)
                    } bookmarkTap: {
                        self.bookmarkTap.send((index, bookmark.id))
                    }
                }
            }
        }
    }
    
    private func presentDetail(data: BookmarkViewModel.ProblemDetail) {
        let answerViewController = BookmarkAnswerViewController()
        answerViewController.configureUI(input: data)
        if let sheet = answerViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 20
        }
        self.present(answerViewController, animated: true)
    }
}

private extension BookmarkViewController {
    func setUI() {
        self.title = "복습 노트"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubview(bookmarkView)
    }
    
    func setLayout() {
        bookmarkView.snp.makeConstraints { make in
            make.bottom.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setTableView() {
        bookmarkView.backgroundColor = .designSystem(.background)
        bookmarkView.separatorStyle = .none
        renderer.target = bookmarkView
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
