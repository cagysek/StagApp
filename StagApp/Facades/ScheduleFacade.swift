//
//  SubjectFacade.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 20.03.2022.
//

import Foundation


protocol IScheduleFacade {
    func loadScheduleActions(for date: Date) async -> [ScheduleAction]
}

struct ScheduleFacade: IScheduleFacade {
    
    let stagService: IStagService
    let studentRepository: IStudentRepository
    let teacherRepository: ITeacherRepository
    
    init(stagService: IStagService, studentRepository: IStudentRepository, teacherRepository: ITeacherRepository) {
        self.stagService = stagService
        self.studentRepository = studentRepository
        self.teacherRepository = teacherRepository
    }
    
    /// TODO sorting..
    public func loadScheduleActions(for date: Date) async -> [ScheduleAction] {
        
        let studentSchedule = await self.loadStudentActions(for: date)
        let teacherSchedule = await self.loadTeacherActions(for: date)
        
        return studentSchedule + teacherSchedule
    }
    
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
    
    
    private func logOutExpiredToken() -> Void {
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.IS_LOGED)
        
        NotificationCenter.default.post(name: .showAlert, object: AlertData(title: "login.expired", msg: "login.expired-text"))
    }
    
}
