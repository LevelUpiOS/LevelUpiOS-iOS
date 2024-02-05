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

struct Bookmark {
    var question: String
    var answer: Bool
    var description: String
    var source: String
}

extension Bookmark {
    static let mock: [Bookmark] = [
        .init(question: "1번문제", answer: true, description: "1번문제해답", source: "swift > optional"),
        .init(question: "2번문제", answer: false, description: "2번문제해답", source: "메모리관리 > ARC"),
        .init(question: "3번문제", answer: true, description: "3번문제해답", source: "FRP > Combine")
    ]
}

final class BookmarkViewController: UIViewController {
    
    let bookmarkView = UITableView(frame: .zero, style: .grouped)
    
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 컴포넌트 설정
        setUI()
        
        renderer.target = bookmarkView
        self.view.addSubview(bookmarkView)
        bookmarkView.snp.makeConstraints { make in
            make.bottom.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        render()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
        // MARK: - button의 addtarget설정
        setAddTarget()
        
        // MARK: - delegate설정
        setDelegate()

    }
    
    func render() {
        renderer.render {
            Group(of: Bookmark.mock) { bookmark in
                BookmarkItem(question: bookmark.question, source: bookmark.source)
            }
        }
    }
}

private extension BookmarkViewController {
    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
