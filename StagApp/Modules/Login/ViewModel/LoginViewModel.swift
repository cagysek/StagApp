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
        
        // on login screen clear all cached data
        self.clearAllCachedData()
    }
    
    private func clearAllCachedData() -> Void {
        // should be false.. check if any data is stored in keychain
        _ = self.keychainManager.removeCookie()
        _ = self.keychainManager.removeUsername()
        
        self.dataManager.deleteStudentCachedData()
        self.dataManager.deleteTeacherCachedData()
        
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.IS_STUDENT)
    }
    
    func getLogin(username: String, password: String) {
        
        self.state = .loading
        
        Task {
            do {
                let data = try await stagService.fetchUserLogin(username: username, password: password)
                
                if (data.cookie != nil) {
                    
                    
                    let result = self.setAuthorizationCookie(cookie: data.cookie!)
                    _ = self.saveUsername(username: username)
                    
                    if (result) {
                        
                        self.state = .fetchingData
                        
                        if (data.studentId != nil) {
                            
                            self.syncStudentData(username: data.username, studentId: data.studentId!)
                        }
                        
                        if (data.teacherId != nil) {
                            self.syncTeacherData(username: data.username, teacherId: data.teacherId!)
                        }
                        
                        self.markUserLogged()
                        self.markIsStudent(studentId: data.studentId)
                        self.markHasTeacherId(teacherId: data.teacherId)
                    }
                }
                
                
                self.state = .idle
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
    
    private func markIsStudent(studentId: String?) -> Void {
        UserDefaults.standard.set(studentId != nil, forKey: UserDefaultKeys.IS_STUDENT)
    }
    
    private func markHasTeacherId(teacherId: Int?) -> Void {
        UserDefaults.standard.set(teacherId != nil, forKey: UserDefaultKeys.HAS_TEACHER_ID)
    }
    
    private func syncStudentData(username: String, studentId: String) -> Void {
        self.dataManager.syncStudentData(username: username, studentId: studentId)
    }
    
    private func syncTeacherData(username: String, teacherId: Int) -> Void {
        self.dataManager.syncTeacherInfo(teacherId: teacherId)
    }
    
    private func setAuthorizationCookie(cookie: String) -> Bool {
        return self.keychainManager.saveCookie(cookieValue: cookie)
    }
    
    private func saveUsername(username: String) -> Bool {
        return self.keychainManager.saveUsername(username: username)
    }
}

