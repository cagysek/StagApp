import Foundation
import Security
import Sentry

@MainActor
/// Protocol to define functions in view model
protocol LoginViewModel: ObservableObject {
    
    /// Function for login user
    /// - Parameters:
    ///   - username: user's username
    ///   - password: user's password
    func getLogin(username: String, password: String)
    
    /// Returns selected university
    func getSelectedUniversity() -> University?
    
    /// Process external login result
    /// - Parameter externalLoginResult: object given from external login service
    func processExternalLogin(externalLoginResult: ExternalLoginResult)
    
    /// Returns login url for external login service based on selected university
    /// - Returns: login url for external login service
    func getLoginUrl() -> String?
}


/// View model for ``LoginScreen
final class LoginViewModelImpl: LoginViewModel {
    
    /// Loading states
    enum State {
            case idle
            case loading
            case error(msg: String)
            case fetchingData
        }
    
    /// Proerty to holding state
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
    
    /// Removes all cached data for user
    private func clearAllCachedData() -> Void {
        // should be false.. check if any data is stored in keychain
        _ = self.keychainManager.removeCookie()
        _ = self.keychainManager.removeUsername()
        
        self.dataManager.deleteStudentCachedData()
        self.dataManager.deleteTeacherCachedData()
        
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.IS_STUDENT)
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.HAS_TEACHER_ID)
    }
    
    public func getLogin(username: String, password: String) {
        
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
                        self.checkRole(role: data.role)
                    }
                }
                
                
                self.state = .idle
            } catch StagServiceError.unauthorized {
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.alert-title", msg: "login.unauthorized"))
            } catch {
                
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.alert-title", msg: "login.error"))
            }
            
            self.state = .idle
        }
    }
    
    public func processExternalLogin(externalLoginResult: ExternalLoginResult) {
        
        self.state = .loading
        
        if (!externalLoginResult.isValid())
        {
            NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.alert-title", msg: "login.error"))
            
            self.state = .idle
            
            return
        }
        
        Task {
                    
            let result = self.setAuthorizationCookie(cookie: externalLoginResult.getStagUserTicket()!)
            _ = self.saveUsername(username: externalLoginResult.getStagUserName()!)

            if (result) {
                self.state = .fetchingData
                
                let studentId = externalLoginResult.getStagUserInfo()?.getStudentId() ?? nil

                if (studentId != nil) {
                    self.syncStudentData(username: externalLoginResult.getStagUserName()!, studentId: studentId!)
                }

                let teacherId = externalLoginResult.getStagUserInfo()?.getTeacherId() ?? nil
                if (teacherId != nil) {
                    self.syncTeacherData(username: externalLoginResult.getStagUserName()!, teacherId: teacherId!)
                }

                self.markUserLogged()
                self.markIsStudent(studentId: studentId)
                self.markHasTeacherId(teacherId: teacherId)
                self.checkRole(role: externalLoginResult.getStagUserRole()!)
            } else {
                
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.alert-title", msg: "login.error"))
            }
            
            self.state = .idle
        }
    }
    
    
    /// Checks role and if role is not supported, shows alert
    /// - Parameter role: user's role
    private func checkRole(role: String) -> Void {
        if (role == "ST" || role == "VY") {
            return;
        }
        
        NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.warning", msg: "login.role-warning", arguments: role))
    }
    
    public func getSelectedUniversity() -> University? {
        
        let selectedUniversity = UserDefaults.standard.integer(forKey: UserDefaultKeys.SELECTED_UNIVERSITY)
        
        if (selectedUniversity == 0)
        {
            return nil
        }
        
        return Universities.getUniversityById(id: selectedUniversity)
    }
    
    public func getLoginUrl() -> String? {
        guard let university = self.getSelectedUniversity() else {
            return nil
        }
        
        return "\(university.url)/login?originalURL=https://www.stag-client.cz&longTicket=true"
    }
    
    
    /// Sets value to UserDefaults, that user is logged
    private func markUserLogged() -> Void {
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.IS_LOGED)
    }
    
    /// Sets value to UserDefaults, if user is student
    private func markIsStudent(studentId: String?) -> Void {
        UserDefaults.standard.set(studentId != nil, forKey: UserDefaultKeys.IS_STUDENT)
    }
    
    /// Sets value to UserDefaults, if user is teacher
    private func markHasTeacherId(teacherId: Int?) -> Void {
        UserDefaults.standard.set(teacherId != nil, forKey: UserDefaultKeys.HAS_TEACHER_ID)
    }
    
    /// Sync student data into database
    /// - Parameters:
    ///   - username: user's username
    ///   - studentId: user's student id
    private func syncStudentData(username: String, studentId: String) -> Void {
        self.dataManager.syncStudentData(username: username, studentId: studentId)
    }
    
    /// Sync teacher data into database
    /// - Parameters:
    ///   - username: user's username
    ///   - teacherId: user's teacher id
    private func syncTeacherData(username: String, teacherId: Int) -> Void {
        self.dataManager.syncTeacherInfo(teacherId: teacherId)
    }
    
    
    /// Saves user's authorization cookie into database
    /// - Parameter cookie: cookie value
    /// - Returns: result of operation
    private func setAuthorizationCookie(cookie: String) -> Bool {
        return self.keychainManager.saveCookie(cookieValue: cookie)
    }
    
    /// Saves user's username into database
    /// - Parameter username: user's username
    /// - Returns: result of operation
    private func saveUsername(username: String) -> Bool {
        return self.keychainManager.saveUsername(username: username)
    }
}

