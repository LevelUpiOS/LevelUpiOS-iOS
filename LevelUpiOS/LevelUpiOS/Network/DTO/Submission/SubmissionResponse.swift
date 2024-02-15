//
//  SubmissionResponse.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation


struct SubmissionResponse: Decodable {
    let submissions: [Submission]
}

struct Submission: Decodable {
    let id: Int
    let examId: Int
    let score: Double
}
