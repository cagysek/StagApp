import Foundation


protocol IDataManager {
    func syncData()
    func syncUserData()
    func syncSubjects()
    func syncAdditionalSubjectInfo()
    func deleteCachedData() -> Void
}


/// This class pro
///
struct DataManager: IDataManager {
    
    let stagApiService: IStagService
    let subjectRepository: ISubjectRepository
    
        
    public func syncData() {
        
        // saves basic student info
        self.syncUserData()

        // first load all subjects results. Request returns all study data
        self.syncSubjects()
    }
    
    /// Saves studens data into database
    public func syncUserData() {
        
        CoreDataManager.deleteStudentInfo()
        
        self.stagApiService.fetchStudentInfo { result in
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
    public func syncAdditionalSubjectInfo() {
        
        guard let yearsAndSemesters = self.subjectRepository.getStudentYearsAndSemesters() else {
            return;
        }
        
        for yearsAndSemester in yearsAndSemesters {
            
            let semester = yearsAndSemester["semester"]!
            let year = yearsAndSemester["year"]!
            
            self.stagApiService.fetchSubjects(year: year, semester: semester) { result in
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
    public func syncSubjects() {

        
        self.stagApiService.fetchSubjectResults { result in
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
                self.syncAdditionalSubjectInfo()
            
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
    
    
    public func deleteCachedData() -> Void {
        CoreDataManager.deleteStudentInfo()
        
        self.subjectRepository.deleteAll();
        
        CoreDataManager.saveContext()
    }
    
    
}
