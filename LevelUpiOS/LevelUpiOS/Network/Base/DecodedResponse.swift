//
//  DecodedResponse.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation


struct DecodedResponse<T: Decodable> {
    let decodedData: T
    let statusCode: Int
}

