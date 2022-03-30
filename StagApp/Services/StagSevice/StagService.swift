//
//  StagService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation
import UIKit

protocol IStagService {
    ///
    func fetch() async throws -> [Credentials]
//    func fetchStudentInfo() async throws -> StudentInfo
    
    /// Fetchs student's exam results async
    func fetchExamResults() async throws -> [SubjectResult]
    
    /// Fetchs student's basic info
    func fetchStudentInfo(studentId: String, completion: @escaping (Result<Student, Error>) -> Void)
    
    /// Fetchs student's subjects
    func fetchSubjects(year: String, semester: String, studentId: String, completion: @escaping (Result<[SubjectApi], Error>) -> Void)
    
    /// Fetchs student's exam results
    func fetchSubjectResults(username: String, studentId: String, completion: @escaping (Result<[SubjectResult], Error>) -> Void)
    
    /// Fetchs student's schedule actions for specific date
    func fetchStudentScheduleActions(studentId: String, for date: Date) async throws -> [ScheduleAction]
    
    /// Fetchs student's exam dates
    func fetchExamDates(studentId: String) async throws -> [Exam]
    
    /// Log in student to exam
    func fetchExamLogIn(studentId: String, username: String, examId: Int) async throws -> String?
    
    /// Logout student from exam
    func fetchExamLogOut(studentId: String, username: String, examId: Int) async throws -> String?
    
    /// Fetchs subject detail
    func fetchSubjectDetailInfo(department: String, short: String) async throws -> SubjectDetail
    
    /// Fetchs subject students
    func fetchSubjectStudents(subjectId: Int) async throws -> [SubjectStudent]
    
    /// Confirm user credentials and return user's informations
    func fetchUserLogin(username: String, password: String) async throws -> LoginResult
    
    /// Fetchs teacher's informations
    func fetchTeacherInfo(teacherId: Int) async throws -> Teacher?
    
    /// Fetchs student's subjects
    func fetchTeacherScheduleActions(teacherId: String, for date: Date) async throws -> [ScheduleAction]
    
    /// Fetchs teache's assigned theses
    func fetchTheses(teacherId: String, assignmentYear: String) async throws -> [Thesis]
}

final class StagService: IStagService {
    
    
    enum StagServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
        case accessDenied
        case unauthorized
        case unknowError
    }
    
    private let LOGIN_COOKIE_NAME = "WSCOOKIE"
    
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
    
    
    public func fetchStudentInfo(studentId: String, completion: @escaping (Result<Student, Error>) -> Void) {
        
        let request = self.getBaseRequest(endpoint: APIConstants.studentInfo, additionalParams: [StagParamsKeys.studentId: studentId])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            print(String(data: data!, encoding: .utf8))
            do {
                let decoder = JSONDecoder(context: CoreDataManager.getContext())
                
                let student = try decoder.decode(Student.self, from: data!)
                completion(.success(student))
            } catch let jsonError {
                print(jsonError)
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
    
    public func fetchSubjects(year: String, semester: String, studentId: String, completion: @escaping (Result<[SubjectApi], Error>) -> Void) {
        
        let request = self.getBaseRequest(
            endpoint: APIConstants.subjects,
            additionalParams: [StagParamsKeys.semester: semester, StagParamsKeys.year: year, StagParamsKeys.studentId: studentId])
        
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
                
//                print(String(data: data!, encoding: .utf8))
                
                
//                completion(.failure(jsonError.localizedDescription as! NSError))
            }
            
        }.resume()
    }
    
    public func fetchSubjectResults(username: String, studentId: String, completion: @escaping (Result<[SubjectResult], Error>) -> Void) {
        
        let request = self.getBaseRequest(endpoint: APIConstants.subjectResults, additionalParams: [StagParamsKeys.studentId: studentId])
        
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
                
                print(String(data: data!, encoding: .utf8))
                
//                fatalError("JSON Parse error")
//                completion(.failure(jsonError.localizedDescription as! NSError))
            }
            
        }.resume()
    }
    
    /**
        Fetch user's data from API
     */
    public func fetchStudentInfoAsync() async throws -> StudentInfo {
        
        var request = getBaseRequest(endpoint: APIConstants.studentInfo)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return try JSONDecoder().decode(StudentInfo.self, from: data)
    }
    
    /**
        Fetch user's data from API
     */
    public func fetchExamResults() async throws -> [SubjectResult] {
        
        var request = getBaseRequest(endpoint: APIConstants.subjectResults)
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
//        let jsonString = String(data: data, encoding: .utf8)
        
        let subjectResultData = try JSONDecoder().decode(SubjectResultDisctionary.self, from: data)
        
        return subjectResultData.subjectResult
    }
    
    
    
    /**
        Fetch schedule actions for user
     */
    public func fetchStudentScheduleActions(studentId: String, for date: Date) async throws -> [ScheduleAction] {
        
        var request = getBaseRequest(
            endpoint: APIConstants.studentScheduleActions,
            additionalParams: [StagParamsKeys.fromDate: DateFormatter.basic.string(from: date), StagParamsKeys.toDate: DateFormatter.basic.string(from: date), StagParamsKeys.studentId: studentId])
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        
        let scheduleActionsData = try JSONDecoder().decode(ScheduleActionsRoot.self, from: data)
        
        return scheduleActionsData.scheduleActions
    }
    
    public func fetchExamDates(studentId: String) async throws -> [Exam] {
        var request = getBaseRequest(endpoint: APIConstants.exams, additionalParams: [StagParamsKeys.studentId: studentId])
        
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 0
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
//        print(String(data: data, encoding: .utf8))
        let examsData = try JSONDecoder().decode(ExamRoot.self, from: data)
        
        return examsData.exams
    }
    
    public func fetchExamLogIn(studentId: String, username: String, examId: Int) async throws -> String? {
        
        var request = getBaseRequest(
            endpoint: APIConstants.examsLogIn,
            additionalParams: [StagParamsKeys.examId: String(examId), StagParamsKeys.studentId: studentId, StagParamsKeys.username: username]
        )
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return String(data: data, encoding: .utf8)
    }
    
    public func fetchExamLogOut(studentId: String, username: String, examId: Int) async throws -> String? {
        
        var request = getBaseRequest(
            endpoint: APIConstants.examsLogOut,
            additionalParams: [StagParamsKeys.examId: String(examId), StagParamsKeys.studentId: studentId, StagParamsKeys.username: username]
        )
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return String(data: data, encoding: .utf8)
    }
    
    
    public func fetchSubjectDetailInfo(department: String, short: String) async throws -> SubjectDetail {
        
        var request = getBaseRequest(endpoint: APIConstants.subjectDetailInfo, additionalParams: [StagParamsKeys.department: department, StagParamsKeys.shortcut: short])
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        return try JSONDecoder().decode(SubjectDetail.self, from: data)
    }
    
    
    public func fetchSubjectStudents(subjectId: Int) async throws -> [SubjectStudent] {
    
        var request = getBaseRequest(endpoint: APIConstants.subjectStudents, additionalParams: [StagParamsKeys.subjectId: String(subjectId)])
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        let subjectStudentsRoot = try JSONDecoder().decode(SubjectStudentRoot.self, from: data)
        
        return subjectStudentsRoot.subjectStudents
    }
    
    public func fetchUserLogin(username: String, password: String) async throws -> LoginResult {
        
        let authData = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
        
        var request = getBaseRequest(endpoint: APIConstants.login)
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        var loginResult = try JSONDecoder().decode(LoginResult.self, from: data)
        
        loginResult.cookie = self.getLoginCookie(response: response)
        
        return loginResult
    }
    
    
    public func fetchTeacherInfo(teacherId: Int) async throws -> Teacher? {
        var request = getBaseRequest(endpoint: APIConstants.teacherInfo, additionalParams: [StagParamsKeys.teacherId: String(teacherId)])
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        let decoder = JSONDecoder(context: CoreDataManager.getContext())
        
        return try decoder.decode(Teacher.self, from: data)
    }
    
    public func fetchTeacherScheduleActions(teacherId: String, for date: Date) async throws -> [ScheduleAction] {
        var request = getBaseRequest(
            endpoint: APIConstants.teacherScheduleActions,
            additionalParams: [StagParamsKeys.fromDate: DateFormatter.basic.string(from: date), StagParamsKeys.toDate: DateFormatter.basic.string(from: date), StagParamsKeys.teacherId: teacherId]
        )
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        
        let scheduleActionsData = try JSONDecoder().decode(ScheduleActionsRoot.self, from: data)
        
        return scheduleActionsData.scheduleActions
    }
    
    public func getTeacherScheduleActions(teacherId: String) async throws -> [ScheduleAction] {
        var request = getBaseRequest(
            endpoint: APIConstants.teacherScheduleActions,
            additionalParams: [StagParamsKeys.teacherId: teacherId]
        )
        
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        let scheduleActionsData = try JSONDecoder().decode(ScheduleActionsRoot.self, from: data)
        
        return scheduleActionsData.scheduleActions
    }
    
    public func fetchTheses(teacherId: String, assignmentYear: String) async throws -> [Thesis] {
        var request = getBaseRequest(
            endpoint: APIConstants.Theses,
            additionalParams: [StagParamsKeys.teacherId: teacherId, StagParamsKeys.assignmentYear: assignmentYear]
        )
        
        let (data, response) = try await self.performRequest(request: &request)
        
        try self.errorHandling(response: response)
        
        
        let thesesRoot = try JSONDecoder().decode(ThesesRoot.self, from: data)
        
        return thesesRoot.theses
    }
    
    
    /**
        Perform request. Adds general modifications to request
     */
    private func performRequest(request: inout URLRequest) async throws -> (Data, URLResponse)
    {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        let urlSession = URLSession(configuration: configuration)
        
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
        } else if (response.statusCode == 401) {
            throw StagServiceError.unauthorized
        } else if (response.statusCode == 403) {
            throw StagServiceError.accessDenied
        }
               
        throw StagServiceError.invalidStatusCode
    }
    
    /// Return login cookie, returns nil if not set
    private func getLoginCookie(response: URLResponse) -> String? {
        
        guard let response = response as? HTTPURLResponse else {
            return nil
        }

        let headers = response.allHeaderFields as! [String: String]
        
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: response.url!)
        
        HTTPCookieStorage.shared.setCookies(cookies, for: response.url!, mainDocumentURL: nil)
        
        for cookie in cookies {
            if (cookie.name == self.LOGIN_COOKIE_NAME) {
                return cookie.value
            }
        }
        
        return nil
    }
    
    
    /// Returns url for request
    /// - Parameter endpoint: API endpoint to call
    
    private func createUrl(endpoint: String, configuration: StagServiceConfiguration) -> URL {
        let url = "\(configuration.baseUri)/services/rest2/\(endpoint)?lang=\(configuration.language)&outputFormat=json"
        
        return URL(string: url)!
    }
    
    /// Returns base request for endpoint with authorization cookie
    /// Request contains base setting
    ///  - Parameter endpoint: Api endpoint to call
    ///  - Parameter additionalParams: additional params to GET request
    private func getBaseRequest(endpoint: String, additionalParams: [String: String] = [:]) -> URLRequest {
        
        let configuration = self.getConfiguration()
        
        var url = self.createUrl(endpoint: endpoint, configuration: configuration)
        
        for (key, value) in additionalParams {
            url = url.appending(key, value: value)
        }
        
        var request = URLRequest(url: url)
        

        request.addValue("WSCOOKIE=\(configuration.cookie)", forHTTPHeaderField: "Cookie")
        
        return request
    }
    
    /// Returns API configuration by user preferences
    private func getConfiguration() -> StagServiceConfiguration {
        
        // load default url by selected university from user storage
        let storedUniversityId = UserDefaults.standard.integer(forKey: UserDefaultKeys.SELECTED_UNIVERSITY)
        var url = ""
        
        if (storedUniversityId != 0) {
            let university = Universities.getUniversityById(id: storedUniversityId)
            
            if (university != nil) {
                url = university!.url
            }
        }
        
        // loads authorization cookie
        let keychain = KeychainManager()
        let cookie = keychain.getCookie() ?? ""
        
        // loads prefered localization, loads system if not set, if system not set loads czech...
        let language = UserDefaults.standard.string(forKey: UserDefaultKeys.LANGUAGE) ?? Locale.current.languageCode ?? "cs"
        
        return StagServiceConfiguration(baseUri: url, language: language, cookie: cookie)
    }
}
