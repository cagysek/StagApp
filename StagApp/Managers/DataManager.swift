import Foundation


protocol IDataManager {
    func syncStudentData(username: String, studentId: String)
    func syncStudentInfo(studentId: String)
    func syncSubjects(username: String, studentId: String)
    func syncAdditionalSubjectInfo(studentId: String)
    func deleteStudentCachedData() -> Void
    func deleteTeacherCachedData() -> Void
    func syncTeacherInfo(teacherId: Int) -> Void
}


/// This class pro
///
struct DataManager: IDataManager {
        
    let stagApiService: IStagService
    let subjectRepository: ISubjectRepository
    let teacherRepository: ITeacherRepository
    
        
    public func syncStudentData(username: String, studentId: String) {
        
        // saves basic student info
        self.syncStudentInfo(studentId: studentId)

        // first load all subjects results. Request returns all study data
        self.syncSubjects(username: username, studentId: studentId)
    }
    
    /// Saves studens data into database
    public func syncStudentInfo(studentId: String) {
        
        CoreDataManager.deleteStudentInfo()
        
        self.stagApiService.fetchStudentInfo(studentId: studentId) { result in
            switch result {
                case .success(let student):
                    
                    CoreDataManager.persistentContainer.viewContext.insert(student)
                    
                    
                    CoreDataManager.saveContext()
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
    /// Saves additional subject informations into database
    public func syncAdditionalSubjectInfo(studentId: String) {
        
        guard let yearsAndSemesters = self.subjectRepository.getStudentYearsAndSemesters() else {
            return;
        }
        
        for yearsAndSemester in yearsAndSemesters {
            
            let semester = yearsAndSemester["semester"]!
            let year = yearsAndSemester["year"]!
            
            self.stagApiService.fetchSubjects(year: year, semester: semester, studentId: studentId) { result in
                switch result {
                    case .success(let subjects):
                        for subject in subjects {
                            
                            //N+1 problem... IDK how to solve this problem better..
                            guard let subjectDb = self.subjectRepository.getSubject(department: subject.department, short: subject.short, year: year, semester: semester) else {
                                continue
                            }

                            _ = self.subjectRepository.insert(self.mapNewPropertiesToSubject(subjectDb: subjectDb, subjectApi: subject))
                            
                            // save context out of the loop causes memory error sometimes..
                            _ = self.subjectRepository.saveContext()
                        }
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                }
            }
        }
        
        
    }
  
    /// Saves student results into database
    public func syncSubjects(username: String, studentId: String) {

        
        self.stagApiService.fetchSubjectResults(username: username, studentId: studentId) { result in
            switch result {
            case .success(let subjectResults):
                
                let subjectMapper = SubjectMapper()
                
                for subjectResult in subjectResults {
                    
                    guard let dbSubject = self.subjectRepository.createNew() else {
                        continue;
                    }
                    
                    let dbSubjectUpdated = subjectMapper.mapNewSubjectFromSubjectResult(subjectResult: subjectResult, subject: dbSubject)
                    
                    _ = self.subjectRepository.insert(dbSubjectUpdated)
                }
                
                _ = self.subjectRepository.saveContext()
            
                
                // loads subject's full names + credits
                self.syncAdditionalSubjectInfo(studentId: studentId)
            
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    /// Maps properties from api request to database object
    private func mapNewPropertiesToSubject(subjectDb: Subject, subjectApi: SubjectApi) -> Subject {
        subjectDb.credits = Int16(subjectApi.credits)
        subjectDb.acknowledged = subjectApi.acknowledged
        subjectDb.type = subjectApi.type
        subjectDb.name = subjectApi.name
       
        return subjectDb
    }
    
    
    public func deleteStudentCachedData() -> Void {
        CoreDataManager.deleteStudentInfo()
        
        self.subjectRepository.deleteAll();
        
        CoreDataManager.saveContext()
    }
    
    
    func deleteTeacherCachedData() {
        self.teacherRepository.delete()
    }
    
    func syncTeacherInfo(teacherId: Int) {
        self.deleteTeacherCachedData()
        
        Task {
            do {
                print(1)
                guard let teacherInfo = try await self.stagApiService.getTeacherInfo(teacherId: teacherId) else {
                    return
                }
                
                print(teacherInfo)
                
                _ = self.teacherRepository.insert(teacherInfo)
                
                _ = self.teacherRepository.saveContext()
                
                
            } catch {
                print(error)
            }
            
        }
        
    }
    
    
}
