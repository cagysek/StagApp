import Foundation

/// Protocol to defines functions for view model
protocol IUniversityViewModel: ObservableObject {
    
    
    /// Returns all supported universities
    /// - Returns: all supported universities
    func getUniversities() -> [University]
    
    /// Saves id of university to UserDefaults
    /// - parameter id: ID of university to save
    func selectUniversity(id: Int) -> Void
}

/// View Model for ``UniversityScreen``
class UniversityViewModel: IUniversityViewModel {
    
    
    public func getUniversities() -> [University] {
        return Universities.universities
    }
    
    public func selectUniversity(id: Int) -> Void {
        
        guard let university = Universities.getUniversityById(id: id) else {
            return
        }
        
        UserDefaults.standard.set(university.id, forKey: UserDefaultKeys.SELECTED_UNIVERSITY)
    }
    
}
