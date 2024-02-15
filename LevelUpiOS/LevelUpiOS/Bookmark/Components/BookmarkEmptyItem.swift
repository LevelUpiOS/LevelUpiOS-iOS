//
//  BookmarkEmptyItem.swift
//  LevelUpiOS
//
//  Created by uiskim on 2/13/24.
//

import UIKit

import Carbon
import SnapKit

struct BookmarkEmptyItem: IdentifiableComponent {
    var title: String = "저장된 북마크가 없습니다:)"
    var id: String {
        return title
    }
    
    func render(in content: BookmarkEmptyComponent) {
        content.titleLabel.text = title
    }
    
    func renderContent() -> BookmarkEmptyComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(width: bounds.width, height: bounds.height)
    }
}

final class BookmarkEmptyComponent: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.black)
        label.font = .pretendard(.regular, ._15)
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
