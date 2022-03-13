//
//  SubjectRepository.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.02.2022.
//

import Foundation
import CoreData


protocol ISubjectRepository {
    func getSubject(department: String?, short: String, year: String, semester: String) -> Subject?
    func saveContext() -> Result<Bool, Error>
    func insert(_ subject: Subject) -> Result<Bool, Error>
    func getStudentYearsAndSemesters() -> [[String : String]]?
    func createNew() -> Subject?
    func getStudyYears() -> [[String : String]]?
    func getSubjects(year: Int, semester: String) -> [Subject]
    func deleteAll() -> Void
    func getTotalCreditsCount() -> Int
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Subject]
}

class SubjectRepository: ISubjectRepository {
    
    private let context: NSManagedObjectContext
    
    // The Core Data book repository.
    private let repository: CoreDataRepository<Subject>
    
    private let ENTITY_NAME: String = "Subject"

    /// Designated initializer
    /// - Parameter context: The context used for storing and quering Core Data.
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Subject>(managedObjectContext: context)
        self.context = context
    }
    
    
    public func getSubject(department: String?, short: String, year: String, semester: String) -> Subject? {
        
        var predicate: NSPredicate
        
        if (department != nil) {
            predicate = NSPredicate(
                format: "department = %@ AND short = %@ AND year = %@ AND semester = %@", department!, short, year, semester
            )
        }
        else
        {
            predicate = NSPredicate(
                format: "short = %@ AND year = %@ AND semester = %@", short, year, semester
            )
        }
        
        
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
        let request = NSFetchRequest<Subject>(entityName: self.ENTITY_NAME)
        
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.ENTITY_NAME)
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.ENTITY_NAME)
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
    
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Subject] {
        let result = self.repository.get(predicate: predicate, sortDescriptors: sortDescriptors)
        
        switch result {
            
        case .success(let subjects):
                return subjects
        case .failure(let error):
                print(error)
                return []
        }
    }
    
    public func getTotalCreditsCount() -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.ENTITY_NAME)
        
        let expression = NSExpressionDescription()
        expression.expression =  NSExpression(forFunction: "sum:", arguments:[NSExpression(forKeyPath: "credits")])
        expression.name = "creditsTotal";
        expression.expressionResultType = NSAttributeType.doubleAttributeType
        
        
        request.propertiesToFetch = [expression]
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        
        let acceptedMarks:[String] = ["1","2","3","S"]
        
        request.predicate = NSPredicate(format: "examDate != NULL AND examGrade IN %@", acceptedMarks)
        
        do {
            
           let results = try self.context.fetch(request)
            
           let resultMap = results[0] as! [String:Int]
            
           return resultMap["creditsTotal"]!
            
       } catch let error as NSError {
           NSLog("Error when summing amounts: \(error.localizedDescription)")
       }
        
        return 0
    }
    
    public func saveContext() -> Result<Bool, Error> {
        return self.repository.saveContext()
    }
    
    public func insert(_ subject: Subject) -> Result<Bool, Error> {
        return self.repository.insert(subject)
    }
    
    public func deleteAll() -> Void {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.ENTITY_NAME)
            let deleteAll = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            try self.context.execute(deleteAll)
            
            _ = self.saveContext()
        } catch {
            
        }
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
