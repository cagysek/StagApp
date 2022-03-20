//
//  ExamsViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.02.2022.
//

import Foundation

protocol IExamsViewModel: ObservableObject {
    
    func loadExams() async -> Void
}

@MainActor
class ExamsViewModel: IExamsViewModel {
    
    @Published var exams: [String: [Exam]] = [:]
    @Published var state: State = .idle
    
    let stagService: IStagService
    let studentRepository: IStudentRepository
    let keychainManager: IKeychainManager
    
    
    enum State {
        case idle
        case loading
    }
    
    init(stagService: IStagService, studentRepository: IStudentRepository, keychainManager: IKeychainManager) {
        self.stagService = stagService
        self.studentRepository = studentRepository
        self.keychainManager = keychainManager
    }
    
    public func loadExams() async -> Void {
        
        self.state = .loading
        
        guard let student = self.studentRepository.getStudent() else {
            self.state = .idle
            return
        }
        
        do {
            self.exams = [:]
            self.exams = try await self.prepareDataForView(data: self.stagService.fetchExamDates(studentId: student.studentId!))
            self.state = .idle
        } catch {
            print(error)
        }
        
    }
    
    private func prepareDataForView(data: [Exam]) -> [String: [Exam]] {
        return Dictionary(grouping: data, by: { $0.subject })
    }
    
    
    public func logInToExam(examId: Int) async -> Bool {
        let student = self.studentRepository.getStudent()!
        let username = self.keychainManager.getUsername()!
      
        do {
            let result = try await self.stagService.fetchExamLogIn(studentId: student.studentId!, username: username, examId: examId)
            
            if (result == "OK") {
                return true
            }
            
        } catch {
            print(error)
            
            return false
        }

        return false
    }
    
    public func logOutFromExam(examId: Int) async -> Bool {
        let student = self.studentRepository.getStudent()!
        let username = self.keychainManager.getUsername()!
        
        do {
            let result = try await self.stagService.fetchExamLogOut(studentId: student.studentId!, username: username, examId: examId)
            
            if (result == "OK") {
                return true
            }
            
        } catch {
            print(error)
            
            return false
        }
        
        return false
    }
    
}
