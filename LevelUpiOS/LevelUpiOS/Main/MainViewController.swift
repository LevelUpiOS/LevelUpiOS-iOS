//
//  MainViewController.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import UIKit
import Combine

import SnapKit
import Carbon

final class MainViewController: UIViewController {
    
    enum ID {
        case top
        case topic
    }
    
    private let viewWillAppear: PassthroughSubject<Void, Never> = .init()
    private let receiveButtonDidTap: PassthroughSubject<Void, Never> = .init()
    private let chapterDidTap: PassthroughSubject<Void, Never> = .init()
    
    private let viewModel: any MainViewModel
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let renderer = Renderer(
        adapter: UICollectionViewFlowLayoutAdapter(),
        updater: UICollectionViewUpdater()
    )
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    init(viewModel: some MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppear.send(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderer.target = collectionView
        setHirerachy()
        setLayout()
        bind()
    }
    
    private func bind() {
        let input = MainViewModelInput(
            viewWillAppear: self.viewWillAppear,
            receiveButtonDidTap: self.receiveButtonDidTap,
            chapterDidTap: self.chapterDidTap
        )
        let output = viewModel.transform(input: input)
        output.topicsAndChapters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subject in
                guard let self else { return }
                self.render(subject: subject)
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI & Layout

extension MainViewController {
    private func setHirerachy() {
        self.view.addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func render(subject: Subject) {
        renderer.render {
            Section(id: ID.top, header: MainHeaderComponent(totalCount: 7, solvedCount: 4))
            
            Group(of: subject.topics) { topic in
                Section(
                    id: ID.topic,
                    header: TopicHeaderComponent(
                        title: topic.name,
                        subtitle: topic.subname
                    )) {
                        Group(of: topic.chapters) { chapter in
                            ChapterComponent(chapter: chapter)
                        }
                    }
            }
        }
    }
}
