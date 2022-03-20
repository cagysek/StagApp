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
    
    let scheduleFacade: IScheduleFacade
    
    
    enum State {
        case idle
        case error(msg: String)
        case fetchingData
    }
    
    init(scheduleFacade: IScheduleFacade) {
        self.scheduleFacade = scheduleFacade
    }
    
    
    public func loadScheduleActions(for date: Date) async -> Void {
        
        self.state = State.fetchingData
        
        self.scheduleActions = await self.scheduleFacade.loadScheduleActions(for: date)
        
        self.state = State.idle
    }
        
}
