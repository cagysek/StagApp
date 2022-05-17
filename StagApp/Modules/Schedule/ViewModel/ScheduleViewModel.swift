import Foundation

/// Protocol to define view model functions
protocol IScheduleViewModel: ObservableObject {
    
    /// Loads schedule actions for given date
    /// - Parameter date: date to load actions
    func loadScheduleActions(for date: Date) async -> Void
}




@MainActor
/// View Model implementation for ``ScheduleSreen``
class ScheduleViewModel: IScheduleViewModel {
    
    /// Array of loaded actions
    @Published var scheduleActions: [ScheduleAction] = []
    
    /// Loading state switcher
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
