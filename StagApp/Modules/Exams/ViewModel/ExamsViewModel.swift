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
    
    let stagService: IStagService
    
    init(stagService: IStagService) {
        self.stagService = stagService
    }
    
    public func loadExams() async -> Void {
        
        do {
            self.exams = [:]
            self.exams = try await self.prepareDataForView(data: self.stagService.fetchExamDates())
        } catch {
            print(error)
        }
        
    }
    
    private func prepareDataForView(data: [Exam]) -> [String: [Exam]] {
        return Dictionary(grouping: data, by: { $0.subject })
    }
    
    
    public func logInToExam(examId: Int) async -> Bool {
        
      
        do {
            let result = try await self.stagService.fetchExamLogIn(examId: examId)
            
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
        do {
            let result = try await self.stagService.fetchExamLogOut(examId: examId)
            
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
