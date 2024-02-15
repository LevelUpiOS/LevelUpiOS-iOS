//
//  MainServiceManager.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation


final class MainServiceManager {
    
    private let categoryService: CategoryService
    
    private let submissionService: SubmissionService
    
    init(categoryService: CategoryService, submissionService: SubmissionService) {
        self.categoryService = categoryService
        self.submissionService = submissionService
    }
    
    func getChapters() async throws -> Subject {
        do {
            async let categories = try self.categoryService.getCategories()
            async let submissions = self.submissionService.getSubmissions()
            
            let categoriesResult = try await categories
            let submissionsResult = try await submissions
            
            return transformToAppData(
                categories: categoriesResult.decodedData,
                submissions: submissionsResult.decodedData
            )
        } catch {
            guard let levelUpError = error as? LevelUpError else {
                throw LevelUpError.unknownError
            }
            throw levelUpError
        }
    }
    
    private func transformToAppData(
        categories: Categories,
        submissions: SubmissionResponse) -> Subject {
            var totalChapterCount = 0
            let topics = categories.categories.map { category in
                let topic = Topic(
                    name: category.name,
                    subname: category.description,
                    chapters: category.exams.map { exam in
                        totalChapterCount += 1
                        var solveType: ChapterSolveType = .yet
                        
                        for submission in submissions.submissions {
                            if submission.examId == exam.id {
                                solveType = .solved(score: Int(submission.score))
                                break
                            }
                        }
                        return Chapter(
                            id: exam.id,
                            name: exam.name,
                            solveType: solveType
                        )
                    }
                )
                return topic
            }
            return Subject(
                topics: topics,
                totalCount: totalChapterCount,
                solvedCount: submissions.submissions.count
            )
    }
    
    
}
