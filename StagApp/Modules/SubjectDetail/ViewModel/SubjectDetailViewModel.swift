//
//  SubjectDetailViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.03.2022.
//

import Foundation

protocol ISubjectDetailViewModel: ObservableObject {
    
    func loadSubjectStudents(subjectId: Int) async -> Void
    
    func loadSubjectDetail(department: String, short: String) async -> Void
}


@MainActor
class SubjectDetailViewModel: ISubjectDetailViewModel {
    
    @Published var subjectDetail: SubjectDetail? = nil
    
    @Published var subjectstudents: [SubjectStudent] = []
    
    let stagService: IStagService
    
    init(stagService: IStagService) {
        self.stagService = stagService
    }
    
    
    public func loadSubjectDetail(department: String, short: String) async -> Void {
        
        do {
            self.subjectDetail = try await self.stagService.fetchSubjectDetailInfo(department: department, short: short)
            
            
        } catch {
            print(error)
        }
        
    }
    
    public func loadSubjectStudents(subjectId: Int) async -> Void {
        do {
            self.subjectstudents = try await self.stagService.fetchSubjectStudents(subjectId: subjectId)
        } catch {
            print(error)
        }
    }
    
}
