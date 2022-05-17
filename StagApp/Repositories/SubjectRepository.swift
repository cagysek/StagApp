import Foundation
import CoreData


/// Protocol to defines subject repository methods
protocol ISubjectRepository {
    
    /// Returns subject by parameters
    /// - Parameters:
    ///   - department: subject's department
    ///   - short: short title of subject
    ///   - year: subject's study year
    ///   - semester: subject's study semester
    /// - Returns: If subject exists, returns instance of ``Subject`` else `nil`
    func getSubject(department: String?, short: String, year: String, semester: String) -> Subject?
    
    
    /// Saves changes to database
    /// - Returns: result of operation
    func saveContext() -> Result<Bool, Error>
    
    
    /// Inserts new instance of ``Subject`` into database
    /// - Parameter subject: instance to insert
    /// - Returns: result of operation
    func insert(_ subject: Subject) -> Result<Bool, Error>
    
    
    /// Returns array of students years grouped by year and semester
    /// - Returns: dictionary year:semester
    func getStudentYearsAndSemesters() -> [[String : String]]?
    
    
    /// Creates new instance of ``Subject``
    /// - Returns: new instance of ``Subject``
    func createNew() -> Subject?
    
    
    /// Returns study years
    /// - Returns: array of study years
    func getStudyYears() -> [[String : String]]?
    
    
    /// Returns all subject for given year and semester
    /// - Parameters:
    ///   - year: subject's year
    ///   - semester: subject's semester
    /// - Returns: array of ``Subject`` by given parameters
    func getSubjects(year: Int, semester: String) -> [Subject]
    
    
    /// Removes all records of ``Subject`` from database
    func deleteAll() -> Void
    
    
    /// Returns total credit count of fulfilled subjects
    /// - Returns: total credit count
    func getTotalCreditsCount() -> Int
    
    
    /// General method for get records
    /// - Parameters:
    ///   - predicate: predicate for filter
    ///   - sortDescriptors: sort description
    /// - Returns: array of ``Subject`` if exists, else `nil`
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
