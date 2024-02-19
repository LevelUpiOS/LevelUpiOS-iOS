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
    private let reviewButtonDidTap: PassthroughSubject<Void, Never> = .init()
    private let chapterDidTap: PassthroughSubject<Int, Never> = .init()
    
    private let viewModel: MainViewModel
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let renderer = Renderer(
        adapter: UICollectionViewFlowLayoutAdapter(),
        updater: UICollectionViewUpdater()
    )
    
    private let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        cv.backgroundColor = .designSystem(.white)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.viewWillAppear.send(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderer.target = collectionView
        setHirerachy()
        setLayout()
        bind()
        render(subject: .init(topics: [], totalCount: 1, solvedCount: 0))
    }
    
    private func bind() {
        let input = MainViewModel.Input(
            viewWillAppear: self.viewWillAppear,
            reviewButtonDidTap: self.reviewButtonDidTap,
            chapterDidTap: self.chapterDidTap
        )
        
        let output = viewModel.transform(input: input)
        output.topics
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subject in
                guard let self else { return }
                self.render(subject: subject)
            }
            .store(in: &cancelBag)
        
        output.chapterDidTap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] chapterId in
                guard let self else { return }
                let viewModel = ProblemSolvingViewModel(id: chapterId, manager: ProblemSolvingManagerImpl(examService: ExamServiceImpl(apiService: APIService())))
                let problemViewController = ProblemSolvingViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(problemViewController, animated: true)
            }
            .store(in: &cancelBag)
        
        output.reviewButtonDidTap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                LUAmplitude.track(eventType: "goToBookmarkView")
                guard let self else { return }
                //TODO: - 복습하러가기 로 넘어가기
                let bookmarkViewController = BookmarkViewController(viewModel: BookmarkViewModel(manager: BookmarkMangerImpl(bookmarkService: BookmarkServiceImpl(apiService: APIService()))))
                self.navigationController?.pushViewController(bookmarkViewController, animated: true)
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
            make.edges.equalToSuperview()
        }
    }

    func render(subject: Subject) {
        renderer.render {
            Section(id: ID.top, header: MainHeaderComponent(
                totalCount: subject.totalCount,
                solvedCount: subject.solvedCount) {
                    self.reviewButtonDidTap.send(())
                }
            )
            
            Group(of: subject.topics) { topic in
                Section(
                    id: ID.topic,
                    header: TopicHeaderComponent(
                        title: topic.name,
                        subtitle: topic.subname
                    )) {
                        Group(of: topic.chapters) { chapter in
                            ChapterComponent(chapter: chapter) {
                                LUAmplitude.track(eventType: "시험시작", eventProperties: ["시험보는챕터ID": chapter.id])
                                self.chapterDidTap.send(chapter.id)
                            }
                        }
                    }
            }
        }
    }
}
