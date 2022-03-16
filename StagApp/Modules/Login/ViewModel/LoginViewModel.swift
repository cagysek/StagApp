//
//  LoginViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation
import Security

@MainActor
protocol LoginViewModel: ObservableObject {
    func getLogin(username: String, password: String)
    
    /// Returns selected university
    func getSelectedUniversity() -> University?
}


final class LoginViewModelImpl: LoginViewModel {

    enum State {
            case idle
            case loading
            case error(msg: String)
            case fetchingData
        }
    
    @Published private(set) var state = State.idle
    
    private let stagService: IStagService
    public let dataManager: IDataManager
    private let keychainManager: IKeychainManager
    
    init(stagService: StagService, dataManager: IDataManager, keychainManager: IKeychainManager) {
        self.stagService = stagService
        self.dataManager = dataManager
        self.keychainManager = keychainManager
        
    }
    
    func getLogin(username: String, password: String) {
        
        self.state = .loading
        
        Task {
            do {
                let data = try await stagService.fetchUserLogin(username: username, password: password)
                    
                
                
                if (data.cookie != nil) {
                    // should be false.. check if cookie value in keychain is not set
                    _ = self.keychainManager.removeCookie()
                    
                    let result = self.setAuthorizationCookie(cookie: data.cookie!)
                    
                    if (result) {
                        
                        self.state = .fetchingData
                        
                        self.syncUserData(username: data.username, studentId: data.studentId!)
                        
                        self.markUserLogged()
                    }
                }
                
                
                self.state = .idle
                
                print(data)
     
            } catch {
                self.state = .idle
                print(error)
            }
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
    
    private func markUserLogged() -> Void {
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.IS_LOGED)
    }
    
    private func syncUserData(username: String, studentId: String) -> Void {
        self.dataManager.deleteCachedData()
        self.dataManager.syncData(username: username, studentId: studentId)
    }
    
    private func setAuthorizationCookie(cookie: String) -> Bool {
        return self.keychainManager.saveCookie(cookieValue: cookie)
    }
}

