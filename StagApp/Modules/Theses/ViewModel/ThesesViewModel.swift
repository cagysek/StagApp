//
//  ThesesViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.03.2022.
//

import Foundation

protocol IThesesViewModel: ObservableObject {
    
}

@MainActor
class ThesesViewModel: IThesesViewModel {
 
    @Published var theses: [Thesis] = []
    @Published var state: AsyncState = .idle
    
    let stagService: IStagService
    let teacherRepository: ITeacherRepository
    
    init (stagService: IStagService, teacherRepository: TeacherRepository) {
        self.stagService = stagService
        self.teacherRepository = teacherRepository
        
        self.loadTheses()
    }
    
    
    public func loadTheses() -> Void {
        
        self.state = .fetchingData

        guard let teacher = self.teacherRepository.getTeacher() else {
            self.state = .idle
            return
        }
        
        Task {
            do {
                self.theses = try await self.stagService.fetchTheses(teacherId: String(teacher.teacherId), assignmentYear: String(2021))
            } catch {
                print(error)
            }
            
            self.state = .idle
        }
        
    }
    
}
