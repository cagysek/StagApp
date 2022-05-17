import Foundation
import SwiftUI


/// Protocol defines functions for view model
protocol IOverviewViewModel: ObservableObject {
    /// Loads notes from database to property
    func updateNotes() -> Void
    
    /// Loads schedule from api to property
    func updateSchedule() -> Void
}


/// View model for ``OverviewScreen``
class OverviewViewModel: IOverviewViewModel {
    @Published var notes: [Note] = []
    @Published var scheduleActions: [ScheduleAction] = []
    @Published var scheduleActionsCount: Int = 0
    @Published var state: AsyncState = .idle
    
    let scheduleFacade: IScheduleFacade
    let noteRepository: INoteRepository
    let keychainManager: IKeychainManager
    
    init(noteRepository: INoteRepository, scheduleFacade: IScheduleFacade, keychainManager: IKeychainManager) {
        self.noteRepository = noteRepository
        self.scheduleFacade = scheduleFacade
        self.keychainManager = keychainManager
    }
    
    @MainActor
    public func updateNotes() -> Void {
        
        guard let username = keychainManager.getUsername() else {
            return
        }
        
        self.notes = self.noteRepository.getByUserName(username: username)
    }
    
    @MainActor
    public func updateSchedule() -> Void {
        
        self.state = .fetchingData
        
        
        Task {
            self.state = .fetchingData
            
            let currentDate = Date()
            
            let items = await self.scheduleFacade.loadScheduleActions(for: currentDate)
            
            self.scheduleActions = self.splitScheduleActionByTimeForView(scheduleActions: items, currentDate: currentDate, itemsToReturn: 2)
            self.scheduleActionsCount = items.count
            
            self.state = .idle
        }
    }
    
    
    /// Prepare data for view. Return subset from given data by current time
    /// - Parameters:
    ///   - scheduleActions: input array with all schedule actions
    ///   - currentDate: current datetime
    ///   - itemsToReturn: how many items return
    /// - Returns: Return subset from given data
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
