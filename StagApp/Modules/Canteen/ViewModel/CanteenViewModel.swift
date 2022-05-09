//
//  CanteenViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation

protocol ICanteenViewModel: ObservableObject {
    func loadCanteenMenu(canteenId: String, selectedDate: Date) -> Void
}


class CanteenViewModel: ICanteenViewModel {
    
    @Published var menu: Menu? = nil
    @Published var state: AsyncState = .idle
    
    let canteenService: ICanteenService
    
    init (canteenService: ICanteenService) {
        self.canteenService = canteenService
    }
    
    @MainActor
    public func loadCanteenMenu(canteenId: String, selectedDate: Date) -> Void
    {
        self.state = .fetchingData
        
        Task {
            do {
                self.menu = try await self.canteenService.fetchMenu(canteenId: canteenId, daysShift: self.getDateDifference(from: Date(), to: selectedDate), language: LanguageService.shared.language)
            }
            catch {
                print(error)
            }
            
            self.state = .idle
        }
    }
    
    private func getDateDifference(from: Date, to: Date) -> Int {
        
        let diffComponents = Calendar.current.dateComponents([.day], from: from.resetTime(), to: to.resetTime())

        return diffComponents.day ?? 0
    }
}
