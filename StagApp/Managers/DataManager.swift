import Foundation


protocol DataManager {
    func syncData()
    func syncUserData()
    func syncSubjectsResult()
    func syncSubjects()
}


/// This class pro
///
struct DataManagerImpl: DataManager {
    
    let stagApiService: StagServiceImpl
    
        
    public func syncData() {
        
        // saves basic student info
        self.syncUserData()

        // first load all results. Request returns all study data
        self.syncSubjectsResult()

        // loads subject's full names + credits
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
    public func syncSubjects() {
        
        guard let yearsAndSemesters = CoreDataManager.getStudentYearsAndSemesters() else {
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
                        guard let subjectDb = CoreDataManager.getSubject(department: subject.department, short: subject.short, year: year, semester: semester) else {
                            continue
                        }
                        
                        
                        CoreDataManager.getContext().insert(self.mapNewPropertiesToSubject(subjectDb: subjectDb, subjectApi: subject))
                        
                    }
                    
                    CoreDataManager.saveContext()
                
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
        
        
    }
  
    /// Saves student results into database
    public func syncSubjectsResult() {
        self.stagApiService.fetchSubjectResults { result in
            switch result {
            case .success(let subjectResults):
                
                let subjectMapper = SubjectMapper()
                
                for subjectResult in subjectResults {
                    
                    let dbSubject = subjectMapper.mapNewSubjectFromSubjectResult(subjectResult: subjectResult, context: CoreDataManager.getContext())
                    
                    CoreDataManager.getContext().insert(dbSubject)
                }
                
                CoreDataManager.saveContext()
            
            
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
       
        return subjectDb
    }
    
    
}
