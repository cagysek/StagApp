//
//  StagServiceError.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.04.2022.
//

import Foundation


/// Enum which defines errors in StagService
enum StagServiceError: Error {
    case failed
    case failedToDecode
    case invalidStatusCode
    case accessDenied
    case unauthorized
    case unknowError
}
