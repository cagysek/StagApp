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
    
    let stagService: IStagService
    
    init(stagService: IStagService) {
        self.stagService = stagService
    }
    
    
    public func loadScheduleActions(for date: Date) async -> Void {
        do {
            self.scheduleActions = try await stagService.fetchScheduleActions(for: date)
        } catch {
            print(error)
        }
    }
    
}
