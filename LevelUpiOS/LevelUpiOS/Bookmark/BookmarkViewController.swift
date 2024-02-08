//
//  BookmarkViewController.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/5/24.
//  Copyright (c) 2024 Bookmark. All rights reserved.
//

import UIKit

import Carbon
import SnapKit

final class BookmarkViewController: UIViewController {
    
    var datas: [Bookmark] = Bookmark.mock {
        didSet {
            render()
        }
    }
    
    let bookmarkView = UITableView(frame: .zero, style: .grouped)
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        render()
        setHierarchy()
        setLayout()
        setAddTarget()
        setDelegate()
    }
    
    func render() {
        renderer.render {
            Group(of: datas.enumerated()) { index, bookmark in
                BookmarkItem(question: bookmark.question, source: bookmark.source) {
                    let answerViewController = BookmarkAnswerViewController()
                    answerViewController.configureUI(question: bookmark.question, answer: bookmark.description, isCorrect: true)
                    if let sheet = answerViewController.sheetPresentationController {
                        sheet.detents = [.medium()]
                        sheet.prefersScrollingExpandsWhenScrolledToEdge = false  // true 기본값
                        sheet.prefersEdgeAttachedInCompactHeight = true // false 기본값
                        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true // false 기본값
                        sheet.preferredCornerRadius = 20
                        sheet.prefersGrabberVisible = true
                    }
                    self.present(answerViewController, animated: true)
                } bookmarkTap: {
                    self.datas.remove(at: index)
                }
            }
        }
    }
}

private extension BookmarkViewController {
    func setUI() {
        self.title = "복습 노트"
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
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
    
    func setTableView() {
        bookmarkView.backgroundColor = .designSystem(.background)
        bookmarkView.separatorStyle = .none
        renderer.target = bookmarkView
    }
}
