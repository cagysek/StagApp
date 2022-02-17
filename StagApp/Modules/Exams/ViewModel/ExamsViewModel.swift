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
    
    @Published var exams: [Exam] = []
    
    let stagService: IStagService
    
    init(stagService: IStagService) {
        self.stagService = stagService
    }
    
    public func loadExams() async -> Void {
        do {
            self.exams = try await self.stagService.fetchExamDates()
            
        } catch {
            print(error)
        }
    }
    
}
