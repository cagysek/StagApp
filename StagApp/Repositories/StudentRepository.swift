import Foundation
import CoreData


/// Protocol which defines functions which communication with table Student
protocol IStudentRepository {
    
    /// Saves context to database
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func saveContext() -> Result<Bool, Error>
    
    
    /// Inserts instanfe of ``Student`` into database
    /// - Parameter student: instance of ``Student`` to insert
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func insert(_ student: Student) -> Result<Bool, Error>
    
    
    /// Creates new instance of ``Student``
    /// - Returns: instance of ``Student``, if error occurs `nil`
    func create() -> Student?
    
    
    /// Returns instance of ``Student`` from database
    /// - Returns: instance of ``Student`` if exists, else `nil`
    func getStudent() -> Student?
}


/// Implementation of ``IStudentRepository``
class StudentRepository: IStudentRepository {
    
    private let repository: CoreDataRepository<Student>
    
    private let context: NSManagedObjectContext
    
    /// Designated initializer
    /// - Parameter context: The context used for storing and quering Core Data.
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Student>(managedObjectContext: context)
        self.context = context
    }
    
    public func saveContext() -> Result<Bool, Error> {
        return self.repository.saveContext()
    }
    
    public func insert(_ student: Student) -> Result<Bool, Error> {
        return self.repository.insert(student)
    }
    
    public func create() -> Student? {
        
        let result = self.repository.create()
        
        switch result {
            case .success(let student):
                return student
                
            case .failure:
                return nil
        }
        
    }
    
    public func getStudent() -> Student? {
        let result =  self.repository.get(predicate: nil, sortDescriptors: nil)
        
        switch result {
            case .success(let students):
            return students.first
        case .failure:
            return nil
        }
    }
}
