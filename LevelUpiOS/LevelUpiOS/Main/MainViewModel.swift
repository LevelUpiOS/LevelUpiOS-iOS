//
//  MainViewModel.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import Foundation
import Combine


protocol ViewModel where Self: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol MainViewModel: ViewModel where Input == MainViewModelInput, Output == MainViewModelOutput {}

struct MainViewModelInput {
    let viewWillAppear: PassthroughSubject<Void, Never>
    let reviewButtonDidTap: PassthroughSubject<Void, Never>
    let chapterDidTap: PassthroughSubject<Int, Never>
}

struct MainViewModelOutput {
    let topics: AnyPublisher<Subject, Never>
    let chapterDidTap: AnyPublisher<Int, Never>
    let reviewButtonDidTap: AnyPublisher<Void, Never>
}

