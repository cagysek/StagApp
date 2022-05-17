import Foundation

/// Protocol for define view model functions
protocol ICanteenViewModel: ObservableObject {
    
    /// Loads canteen menu for specific canteen and date
    /// - Parameters:
    ///   - canteenId: canteen to load menu
    ///   - selectedDate: date for load menu
    func loadCanteenMenu(canteenId: String, selectedDate: Date) -> Void
}


/// View model implementation for ``CanteenScreen``
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
    
    /// Counts difference between two dates
    /// - Parameters:
    ///   - from: from date
    ///   - to: to date
    /// - Returns: difference between two dates
    private func getDateDifference(from: Date, to: Date) -> Int {
        
        let diffComponents = Calendar.current.dateComponents([.day], from: from.resetTime(), to: to.resetTime())

        return diffComponents.day ?? 0
    }
}
