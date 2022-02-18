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
            self.exams = try await self.prepareDataForView(data: self.stagService.fetchExamDates())
        } catch {
            print(error)
        }
    }
    
    private func prepareDataForView(data: [Exam]) -> [String: [Exam]] {
        
        return Dictionary(grouping: data, by: { $0.subject })
        
//        return data.reduce(into: [String: [Exam]]()) { (dictionary, exam) -> [String: [Exam]] in
//
//            if (dictionary[exam.subject] != nil) {
//                dictionary[exam.subject] = dictionary[exam.subject].append(contentsOf: exam)
//            }
//            else {
//                dictionary[exam.subject] = [exam]
//            }
//        }
    }
    
}
