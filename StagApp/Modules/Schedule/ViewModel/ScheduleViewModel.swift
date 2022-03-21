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
    @Published var state: AsyncState = .idle
    
    let scheduleFacade: IScheduleFacade
    
    init(scheduleFacade: IScheduleFacade) {
        self.scheduleFacade = scheduleFacade
    }
    
    
    public func loadScheduleActions(for date: Date) async -> Void {
        
        self.state = AsyncState.fetchingData
        
        self.scheduleActions = await self.scheduleFacade.loadScheduleActions(for: date)
        
        self.state = AsyncState.idle
    }
        
}
