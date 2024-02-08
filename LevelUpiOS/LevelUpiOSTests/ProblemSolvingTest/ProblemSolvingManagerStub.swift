//
//  ProblemSolvingManagerStub.swift
//  LevelUpiOSTests
//
//  Created by uiskim on 1/31/24.
//

import Foundation

@testable import LevelUpiOS

final class ProblemSolvingManagerStub: ProblemSolvingManager {
    var data: Problem?
    
    func set(data: Problem) {
        self.data = data
    }

    func getQuiz(from subjectId: Int) async throws -> Problem {
        guard let data = self.data else {
            throw ProblemSolvingError.emptyData
        }
        return data
    }
}
