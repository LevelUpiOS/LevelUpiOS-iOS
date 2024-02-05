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
                    print("해당문제의 답은")
                    print("\(bookmark.answer)")
                    print("\(bookmark.description)")
                } bookmarkTap: {
                    print("누른 북마크 인덱스")
                    print("\(index)")
                    self.datas.remove(at: index)
                }
            }
        }
    }
}

private extension BookmarkViewController {
    func setUI() {
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
