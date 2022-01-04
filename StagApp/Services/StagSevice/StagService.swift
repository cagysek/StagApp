//
//  StagService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

protocol StagService {
    func fetch() async throws -> [Credentials]
    func fetchStudentInfo() async throws -> StudentInfo
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
    
    public func fetchStudentInfo() async throws -> StudentInfo {
        let urlSession = URLSession.shared
        
        let url = URL(string: APIConstants.baseUrl.appending(APIConstants.studentInfo))
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let authData = (SecretConstants.username + ":" + SecretConstants.password).data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        
        let (data, response) = try await urlSession.data(for: request)
        
        let status = response as? HTTPURLResponse
        print(status?.statusCode)
        
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw StagServiceError.invalidStatusCode
              }
        
        
        var a = try JSONDecoder().decode(StudentInfo.self, from: data)
        
        return a
    }
}
