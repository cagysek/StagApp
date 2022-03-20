//
//  OverviewViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.03.2022.
//

import Foundation
import SwiftUI


protocol IOverviewViewModel: ObservableObject {
    /// Loads notes from database to property
    func updateNotes() -> Void
    
    /// Loads schedule from api to property
    func updateSchedule() -> Void
}


class OverviewViewModel: IOverviewViewModel {
    @Published var notes: [Note] = []
    @Published var scheduleActions: [ScheduleAction] = []
    @Published var scheduleActionsCount: Int = 0
    
    let stagService: IStagService
    let noteRepository: INoteRepository
    let studentRepository: IStudentRepository
    
    init(stagService: StagService, noteRepository: INoteRepository, studentRepository: IStudentRepository) {
        self.stagService = stagService
        self.noteRepository = noteRepository
        self.studentRepository = studentRepository
        
        self.updateNotes()
    }
    
    
    public func updateNotes() -> Void {
        self.notes = self.noteRepository.getAll()
    }
    
    public func updateSchedule() -> Void {
        
//        self.state = State.fetchingData
        
        let student = self.studentRepository.getStudent()!
        
        Task {
            do {
                let items = try await self.stagService.fetchScheduleActions(studentId: student.studentId!, for: Date())
                
                let currentDate = Date()
                
                DispatchQueue.main.async {
                    self.scheduleActions = self.splitScheduleActionByTimeForView(scheduleActions: items, currentDate: currentDate, itemsToReturn: 2)
                    self.scheduleActionsCount = items.count
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    
    private func splitScheduleActionByTimeForView(scheduleActions: [ScheduleAction], currentDate: Date, itemsToReturn: Int) -> [ScheduleAction] {
        let currentTime = DateFormatter.time.string(from: currentDate)
        
        let currentTimeToDate = DateFormatter.time.date(from: currentTime)
        
        var filledIndex = 0
        
        var returnArray: [ScheduleAction] = []
        
        for (_, scheduleAction) in scheduleActions.enumerated() {
            let scheduleTimeDate = DateFormatter.time.date(from: scheduleAction.timeTo!.value)
            
            if (currentTimeToDate! < scheduleTimeDate!) {
                returnArray.append(scheduleAction)
                
                filledIndex += 1
                
                if (filledIndex == itemsToReturn) {
                    break
                }
            }
        }
        
        return returnArray
    }
}
