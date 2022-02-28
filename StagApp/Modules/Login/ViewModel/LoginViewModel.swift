//
//  LoginViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

@MainActor
protocol LoginViewModel: ObservableObject {
    func getLogin() async
    
    /// Returns selected university
    func getSelectedUniversity() -> University?
}


final class LoginViewModelImpl: LoginViewModel {

    @Published private(set) var data: [Credentials] = []
    
    private let stagService: StagService
    
    init(stagService: StagService) {
        self.stagService = stagService
    }
    
    func getLogin() async {
        do {
            self.data = try await stagService.fetch()
        } catch {
            print(error)
        }
    }
    
    public func getSelectedUniversity() -> University? {
        
        let selectedUniversity = UserDefaults.standard.integer(forKey: UserDefaultKeys.SELECTED_UNIVERSITY)
        
        if (selectedUniversity == 0)
        {
            return nil
        }
        
        return Universities.getUniversityById(id: selectedUniversity)
    }
}

