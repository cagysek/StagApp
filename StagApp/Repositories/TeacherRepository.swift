import Foundation
import CoreData


/// Protocol which defines methods which communication with table Teacher
protocol ITeacherRepository {
    
    /// Save context to datbase
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func saveContext() -> Result<Bool, Error>
    
    /// Inserts instance of ``Teacher`` to database
    /// - Parameter teacher: instance of ``Teacher`` to insert
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func insert(_ teacher: Teacher) -> Result<Bool, Error>
    
    /// Creates new instance of ``Teacher``
    /// - Returns: instance of ``Teacher``, if error occurs `nil`
    func create() -> Teacher?
    
    /// Returns instance of ``Teacher``
    /// - Returns: instance of ``Teacher``, or `nil` if not exists
    func getTeacher() -> Teacher?
    
    
    /// Removes all data from table
    func delete() -> Void 
}


class TeacherRepository: ITeacherRepository {
    
    private let repository: CoreDataRepository<Teacher>
    
    private let context: NSManagedObjectContext
    
    
    /// Designated initializer
    /// - Parameter context: The context used for storing and quering Core Data.
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Teacher>(managedObjectContext: context)
        self.context = context
    }
    
    public func saveContext() -> Result<Bool, Error> {
        return self.repository.saveContext()
    }
    
    public func insert(_ teacher: Teacher) -> Result<Bool, Error> {
        return self.repository.insert(teacher)
    }
    
    public func create() -> Teacher? {
        
        let result = self.repository.create()
        
        switch result {
            case .success(let teacher):
                return teacher
                
            case .failure:
                return nil
        }
        
    }
    
    public func getTeacher() -> Teacher? {
        let result =  self.repository.get(predicate: nil, sortDescriptors: nil)
        
        switch result {
            case .success(let teacher):
            return teacher.first
        case .failure:
            return nil
        }
    }
    
    public func delete() -> Void {
        let teacher = self.getTeacher()
        
        if (teacher != nil) {
            _ = self.repository.delete(entity: teacher!)
        }
        
        _ = self.saveContext()
    }
}


