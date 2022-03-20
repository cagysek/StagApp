//
//  ScheduleViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.02.2022.
//

import Foundation

protocol IScheduleViewModel: ObservableObject {
    func loadScheduleActions(for date: Date) async -> Void
}




@MainActor
class ScheduleViewModel: IScheduleViewModel {
    
    @Published var scheduleActions: [ScheduleAction] = []
    @Published var state: State = State.idle
    
    let stagService: IStagService
    let studentRepository: IStudentRepository
    
    
    enum State {
        case idle
        case error(msg: String)
        case fetchingData
    }
    
    init(stagService: IStagService, studentRepository: IStudentRepository) {
        self.stagService = stagService
        self.studentRepository = studentRepository
    }
    
    
    public func loadScheduleActions(for date: Date) async -> Void {
        
        self.state = State.fetchingData
        
        let student = self.studentRepository.getStudent()!
        
        do {
            self.scheduleActions = try await stagService.fetchScheduleActions(studentId: student.studentId!, for: date)
            
            self.state = State.idle
        } catch {
            print(error)
        }
    }
    
}
