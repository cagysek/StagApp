//
//  StagService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

protocol StagService {
    func fetch() async throws -> [Credentials]
}

final class StagServiceImpl: StagService {
 
    enum StagServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetch() async throws -> [Credentials] {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstants.baseUrl.appending("/api/..."))
        let (data, response) = try await urlSession.data(from: url!)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw StagServiceError.invalidStatusCode
              }
        
        return try JSONDecoder().decode([Credentials].self, from: data)
    }
}
