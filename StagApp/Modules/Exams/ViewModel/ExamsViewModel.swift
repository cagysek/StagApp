import Foundation


/// Protocol to define functions for view model
protocol IExamsViewModel: ObservableObject {
    
    /// Loads exams
    func loadExams() async -> Void
    
    /// Log out from exam by id
    /// - Parameter examId: ID of exam to log out
    /// - Returns: result of operation
    func logOutFromExam(examId: Int) async -> Bool
    
    /// Log in user to exam by id
    /// - Parameter examId: ID of exam to log in
    /// - Returns: result of operation
    func logInToExam(examId: Int) async -> Bool
}

@MainActor
/// View model for ``ExamsScreen``
class ExamsViewModel: IExamsViewModel {
    
    /// Array of loaded exams
    @Published var exams: [String: [Exam]] = [:]
    
    /// Loading state
    @Published var state: AsyncState = .idle
    
    let stagService: IStagService
    let studentRepository: IStudentRepository
    let keychainManager: IKeychainManager
    
    
    enum State {
        case idle
        case loading
    }
    
    init(stagService: IStagService, studentRepository: IStudentRepository, keychainManager: IKeychainManager) {
        self.stagService = stagService
        self.studentRepository = studentRepository
        self.keychainManager = keychainManager
    }
    
    public func loadExams() async -> Void {
        
        self.state = .fetchingData
        
        guard let student = self.studentRepository.getStudent() else {
            self.state = .idle
            return
        }
        
        do {
            self.exams = [:]
            self.exams = try await self.prepareDataForView(data: self.stagService.fetchExamDates(studentId: student.studentId!))
            self.state = .idle
        } catch {
            print(error)
        }
        
    }
    
    /// Prepares data for view. Group exams by subject
    /// - Parameter data: array of all exams
    /// - Returns: grouped data
    private func prepareDataForView(data: [Exam]) -> [String: [Exam]] {
        return Dictionary(grouping: data, by: { $0.subject })
    }
    
    
    public func logInToExam(examId: Int) async -> Bool {
        let student = self.studentRepository.getStudent()!
        let username = self.keychainManager.getUsername()!
      
        do {
            let result = try await self.stagService.fetchExamLogIn(studentId: student.studentId!, username: username, examId: examId)
            
            if (result == "OK") {
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-log-in-success", msg: "exam.log-in-success"))
                
                return true
            } else {
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-error", msg: result ?? "exam.error"))
            }
            
            
        } catch {
            NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-error", msg: "exam.error"))
            
            return false
        }

        return false
    }
    
    public func logOutFromExam(examId: Int) async -> Bool {
        let student = self.studentRepository.getStudent()!
        let username = self.keychainManager.getUsername()!
        
        do {
            let result = try await self.stagService.fetchExamLogOut(studentId: student.studentId!, username: username, examId: examId)
            
            if (result == "OK") {
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-log-in-success", msg: "exam.log-in-success"))
                
                return true
            } else {
                NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-error", msg: result ?? "exam.error"))
            }
            
        } catch {
            NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "exam.alert-title-error", msg: "exam.error"))
            
            return false
        }
        
        return false
    }
    
}
