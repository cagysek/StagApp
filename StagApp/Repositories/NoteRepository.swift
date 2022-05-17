import Foundation
import CoreData


/// Protocol which defines methods for communication with table Note
protocol INoteRepository{
    
    /// Saves changes database
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func saveContext() -> Result<Bool, Error>
    
    
    /// Inserts object of ``Note`` to database
    /// - Parameter note: instance of ``Note`` to insert
    /// - Returns: result consisting of either a Bool set to true or an Error.
    func insert(_ note: Note) -> Result<Bool, Error>
    
    
    /// Creates new instance of ``Note``
    /// - Returns: new instance of ``Note``, `nil` if error occurs
    func create() -> Note?
    
    
    /// Returns all notes stored in database
    /// - Returns: array of ``Note``
    func getAll() -> [Note]
    
    
    /// Returns array of ``Note`` by given username
    /// - Parameter username: username for loads notes
    /// - Returns: array of ``Note`` which contains given username
    func getByUserName(username: String) -> [Note]
    
    /// Deletes a NSManagedObject entity.
    /// - Parameter note: The `Note` to be deleted.
    /// - Returns: A result consisting of either a Bool set to true or an Error.
    func delete(note: Note) -> Bool
}


/// Implementation of ``INoteRepository``
class NoteRepository: INoteRepository {
    
    private let repository: CoreDataRepository<Note>
    
    private let context: NSManagedObjectContext
    
    /// Designated initializer
    /// - Parameter context: The context used for storing and quering Core Data.
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Note>(managedObjectContext: context)
        self.context = context
    }
    
    public func saveContext() -> Result<Bool, Error> {
        return self.repository.saveContext()
    }
    
    public func insert(_ note: Note) -> Result<Bool, Error> {
        return self.repository.insert(note)
    }
    
    public func create() -> Note? {
        
        let result = self.repository.create()
        
        switch result {
            case .success(let note):
                return note
                
            case .failure:
                return nil
        }
        
    }
    
    public func getAll() -> [Note] {
        let result =  self.repository.get(predicate: nil, sortDescriptors: nil)
        
        switch result {
            case .success(let notes):
                return notes
        case .failure:
            return []
        }
    }
    
    public func getByUserName(username: String) -> [Note] {
        
        let predicate = NSPredicate(format: "userName = %@", username)
        
        let result =  self.repository.get(predicate: predicate, sortDescriptors: nil)
        
        switch result {
            case .success(let notes):
                return notes
        case .failure:
            return []
        }
    }
    
    public func delete(note: Note) -> Bool {
        let result = self.repository.delete(entity: note)
        
        switch result {
            case .success(let success):
                return success
            case .failure:
                return false
        }
    }
}
