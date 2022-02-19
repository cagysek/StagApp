//
//  StagService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

protocol IStagService {
    ///
    func fetch() async throws -> [Credentials]
//    func fetchStudentInfo() async throws -> StudentInfo
    
    /// Fetchs student's exam results async
    func fetchExamResults() async throws -> [SubjectResult]
    
    /// Fetchs student's basic info
    func fetchStudentInfo(completion: @escaping (Result<Student, Error>) -> Void)
    
    /// Fetchs student's subjects
    func fetchSubjects(year: String, semester: String, completion: @escaping (Result<[SubjectApi], Error>) -> Void)
    
    /// Fetchs student's exam results
    func fetchSubjectResults(completion: @escaping (Result<[SubjectResult], Error>) -> Void)
    
    /// Fetchs student's schedule actions for specific date
    func fetchScheduleActions(for date: Date) async throws -> [ScheduleAction]
    
    /// Fetchs student's exam dates
    func fetchExamDates() async throws -> [Exam]
    
    /// Log in student to exam
    func fetchExamLogIn(examId: Int) async throws -> String?
    
    /// Logout student from exam
    func fetchExamLogOut(examId: Int) async throws -> String?
}

final class StagService: IStagService {
    
//    let coreData = CoreDataService()
 
    enum StagServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
        case notAuthorized
        case unknowError
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
    
    
    public func fetchStudentInfo(completion: @escaping (Result<Student, Error>) -> Void) {
        let url = self.createUrl(endpoint: APIConstants.studentInfo)
        
        var request = URLRequest(url: url)
        let authData = (SecretConstants.username + ":" + SecretConstants.password).data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let decoder = JSONDecoder(context: CoreDataManager.getContext())
                
                let student = try decoder.decode(Student.self, from: data!)
                completion(.success(student))
            } catch let jsonError {
                print(jsonError)
                completion(.failure(jsonError.localizedDescription as! Error))
            }
            
        }.resume()
    }
    
    
    public func fetchSubjects(year: String, semester: String, completion: @escaping (Result<[SubjectApi], Error>) -> Void) {
        var url = self.createUrl(endpoint: APIConstants.subjects)
        
        url = url.appending("semestr", value: semester).appending("rok", value: year)
        
        var request = URLRequest(url: url)
        let authData = (SecretConstants.username + ":" + SecretConstants.password).data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let decoder = JSONDecoder(context: CoreDataManager.getContext())

                let subjects = try decoder.decode(RootSubject.self, from: data!)
                
                completion(.success(subjects.subjectResult))
            } catch let jsonError {
                print(jsonError)
                
                fatalError("JSON Parse error")
//                completion(.failure(jsonError.localizedDescription as! NSError))
            }
            
        }.resume()
    }
    
    public func fetchSubjectResults(completion: @escaping (Result<[SubjectResult], Error>) -> Void) {
        let url = self.createUrl(endpoint: APIConstants.subjectResults)
//        url = url.appending("semestr", value: "ZS").appending("rok", value: "2020")
        
        var request = URLRequest(url: url)
        let authData = (SecretConstants.username + ":" + SecretConstants.password).data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let subjects = try decoder.decode(SubjectResultDisctionary.self, from: data!)
                
                completion(.success(subjects.subjectResult))
            } catch let jsonError {
                print(jsonError)
                
                fatalError("JSON Parse error")
//                completion(.failure(jsonError.localizedDescription as! NSError))
            }
            
        }.resume()
    }
    
    /**
        Fetch user's data from API
     */
    public func fetchStudentInfoAsync() async throws -> StudentInfo {
        let url = self.createUrl(endpoint: APIConstants.studentInfo)
        
        var request = URLRequest(url: url)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return try JSONDecoder().decode(StudentInfo.self, from: data)
    }
    
    /**
        Fetch user's data from API
     */
    public func fetchExamResults() async throws -> [SubjectResult] {
        
        let url = self.createUrl(endpoint: APIConstants.subjectResults)
        
        var request = URLRequest(url: url)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
//        let jsonString = String(data: data, encoding: .utf8)
        
        let subjectResultData = try JSONDecoder().decode(SubjectResultDisctionary.self, from: data)
        
        return subjectResultData.subjectResult
    }
    
    
    
    /**
        Fetch schedule actions for user
     */
    public func fetchScheduleActions(for date: Date) async throws -> [ScheduleAction] {
        
        var url = self.createUrl(endpoint: APIConstants.scheduleActions)
        url = url.appending("datumOd", value: DateFormatter.basic.string(from: date))
                 .appending("datumDo", value: DateFormatter.basic.string(from: date))
        
        var request = URLRequest(url: url)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        
        let scheduleActionsData = try JSONDecoder().decode(ScheduleActionsRoot.self, from: data)
        
        return scheduleActionsData.scheduleActions
    }
    
    public func fetchExamDates() async throws -> [Exam] {
        
        let url = self.createUrl(endpoint: APIConstants.exams)
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 0)
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        print(String(data: data, encoding: .utf8))
        let examsData = try JSONDecoder().decode(ExamRoot.self, from: data)
        
        return examsData.exams
    }
    
    public func fetchExamLogIn(examId: Int) async throws -> String? {
        
        let url = self.createUrl(endpoint: APIConstants.examsLogIn).appending("termIdno", value: String(examId))
        
        var request = URLRequest(url: url)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return String(data: data, encoding: .utf8)
    }
    
    public func fetchExamLogOut(examId: Int) async throws -> String? {
        
        let url = self.createUrl(endpoint: APIConstants.examsLogOut).appending("termIdno", value: String(examId))
        
        var request = URLRequest(url: url)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return String(data: data, encoding: .utf8)
    }
    
    /**
        Perform request. Adds general modifications to request
     */
    private func performRequest(request: inout URLRequest) async throws -> (Data, URLResponse)
    {
        let configuration = URLSessionConfiguration.ephemeral
        
        
        let urlSession = URLSession(configuration: configuration)
        
        let authData = (SecretConstants.username + ":" + SecretConstants.password).data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        return try await urlSession.data(for: request)
    }
    
    /**
        Validate status code of response. If code is not 200, throws error according to status code
     */
    private func errorHandling(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw StagServiceError.unknowError
        }
        
        if (response.statusCode == 200) {
            return
        } else if (response.statusCode == 403) {
            throw StagServiceError.notAuthorized
        }
               
        throw StagServiceError.invalidStatusCode
    }
    
    /**
        Returns url for request
        - endpoint: API endpoint to call
        - lang: output language
        - outputFormat: output formating
     */
    private func createUrl(endpoint: String, lang: String = "cs", outputFormat: String = "JSON") -> URL {
        
        let url = APIConstants.baseUrl.appending(endpoint).appending("?lang=\(lang)&outputFormat=\(outputFormat)&osCislo=\(SecretConstants.username)&stagUser=\(SecretConstants.username)")
        
        return URL(string: url)!
    }
}
