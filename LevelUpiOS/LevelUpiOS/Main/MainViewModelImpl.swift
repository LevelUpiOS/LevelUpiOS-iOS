//
//  MainViewModelImpl.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/31/24.
//

import Foundation
import Combine


final class MainViewModelImpl: MainViewModel {
    func transform(input: MainViewModelInput) -> MainViewModelOutput {
        let subject = input.viewWillAppear
            .map { _ in
                return Subject.dummy
            }
            .eraseToAnyPublisher()
        
        
        return Output(topicsAndChapters: subject)
    }
    
    
}
