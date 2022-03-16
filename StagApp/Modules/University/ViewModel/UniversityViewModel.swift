//
//  UniversityViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.02.2022.
//

import Foundation

protocol IUniversityViewModel: ObservableObject {
    
    /// Returns al supported universities
    func getUniversities() -> [University]
    
    /// Saves id of university to UserDefaults
    /// - parameter id: ID of university to save
    func selectUniversity(id: Int) -> Void
}

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
