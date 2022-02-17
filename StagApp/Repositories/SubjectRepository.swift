//
//  SubjectRepository.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.02.2022.
//

import Foundation
import CoreData


protocol ISubjectRepository {
    func getSubject(department: String, short: String, year: String, semester: String) -> Subject?
    func saveContext() -> Result<Bool, Error>
    func insert(_ subject: Subject) -> Result<Bool, Error>
    func getStudentYearsAndSemesters() -> [[String : String]]?
    func createNew() -> Subject?
    func getStudyYears() -> [[String : String]]?
    func getSubjects(year: Int, semester: String) -> [Subject]
}

class SubjectRepository: ISubjectRepository {
    
    private let context: NSManagedObjectContext
    
    // The Core Data book repository.
    private let repository: CoreDataRepository<Subject>

    /// Designated initializer
    /// - Parameter context: The context used for storing and quering Core Data.
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Subject>(managedObjectContext: context)
        self.context = context
    }
    
    
    public func getSubject(department: String, short: String, year: String, semester: String) -> Subject? {
        
        let predicate = NSPredicate(
            format: "department = %@ AND short = %@ AND year = %@ AND semester = %@", department, short, year, semester
        )
        
        
        let result = self.repository.get(predicate: predicate, sortDescriptors: [])
        
        switch result {
            case .success(let subject):
            
                return subject.first
            case .failure:
                // Return the Core Data error.
                return nil
        }
            
    }
    
    public func getSubjects(year: Int, semester: String) -> [Subject] {
        let request = NSFetchRequest<Subject>(entityName: "Subject")
        
        request.predicate = NSPredicate(format: "year = %@ AND semester = %@", String(year), semester)
        
        do {
            return try self.context.fetch(request)
            
        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            print(error)
        }
        
        return []
    }
    
    
    public func getStudentYearsAndSemesters() -> [[String : String]]?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        request.returnsObjectsAsFaults = false
        request.propertiesToGroupBy = ["year", "semester"]
        request.propertiesToFetch = ["year", "semester"]
        request.resultType = .dictionaryResultType
        
        do {
            let data = try self.context.fetch(request)
            
            let dataDict = data as! [[String: String]]
            
            return dataDict
            
        } catch {
//            let nserror = error as NSError
            print(error)
            
        }
        
        return nil;
    }
    
    public func getStudyYears() -> [[String : String]]?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        request.returnsObjectsAsFaults = false
        request.propertiesToGroupBy = ["year"]
        request.propertiesToFetch = ["year"]
        request.resultType = .dictionaryResultType
        request.predicate = NSPredicate(format: "semester = \"ZS\"")
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false)]
        
        do {
            let data = try self.context.fetch(request)
            
            let dataDict = data as! [[String: String]]
            
            return dataDict
            
        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            print(error)
        }
        
        return nil;
    }
    
    public func saveContext() -> Result<Bool, Error> {
        return self.repository.saveContext()
    }
    
    public func insert(_ subject: Subject) -> Result<Bool, Error> {
        return self.repository.insert(subject)
    }
    
    public func createNew() -> Subject? {
        
        let result = self.repository.create()
        
        switch result {
            case .success(let subject):
                return subject
                
            case .failure:
                print("error")
                return nil
        }
        
    }
    
}
