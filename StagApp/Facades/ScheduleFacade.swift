import Foundation



/// Protocol for loads schedule actions
protocol IScheduleFacade {
    
    /// Loads user schedule actions for specific date
    /// - Parameter date: Date to load schedule actions
    /// - Returns: array of schedule actions
    func loadScheduleActions(for date: Date) async -> [ScheduleAction]
}



/// Schedule action facade implementation, implements ``IScheduleFacade``
struct ScheduleFacade: IScheduleFacade {
    
    let stagService: IStagService
    let studentRepository: IStudentRepository
    let teacherRepository: ITeacherRepository
    
    init(stagService: IStagService, studentRepository: IStudentRepository, teacherRepository: ITeacherRepository) {
        self.stagService = stagService
        self.studentRepository = studentRepository
        self.teacherRepository = teacherRepository
    }
    
    
    /// Loads user schedule actions for specific date
    /// - Parameter date: date to load schedule actions
    /// - Returns: array of schedule actions
    public func loadScheduleActions(for date: Date) async -> [ScheduleAction] {
        
        let studentSchedule = await self.loadStudentActions(for: date)
        let teacherSchedule = await self.loadTeacherActions(for: date)
        
        return studentSchedule + teacherSchedule
    }
    
    
    /// Loads student schedule actions for specific date
    /// - Parameter date: date to load schedule actions
    /// - Returns: array of schedule actions
    private func loadStudentActions(for date: Date) async -> [ScheduleAction] {
        
        guard let student = self.studentRepository.getStudent() else {
            return []
        }
        
        do {
            return try await stagService.fetchStudentScheduleActions(studentId: student.studentId!, for: date)
        // if auth token expired
        } catch StagServiceError.unauthorized {
            
            self.logOutExpiredToken()
        } catch {
            print(error)
        }
        
        return []
    }
    
    
    /// Loads teacher schedule actions for specific date
    /// - Parameter date: dato to load schedule actions
    /// - Returns: array of schedule actuons
    private func loadTeacherActions(for date: Date) async -> [ScheduleAction] {
        
        guard let teacher = self.teacherRepository.getTeacher() else {
            return []
        }
        
        do {
            return try await stagService.fetchTeacherScheduleActions(teacherId: String(teacher.teacherId), for: date)
        } catch StagServiceError.unauthorized {
            self.logOutExpiredToken()
        } catch {
            print(error)
        }
        
        return []
    }
    
    
    /// Log out user from app, sets UserDefaults value "is_logged" to false
    private func logOutExpiredToken() -> Void {
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.IS_LOGED)
        
        NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.expired", msg: "login.expired-text"))
    }
    
}
