//
//  NoteRepository.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.03.2022.
//

import Foundation
import CoreData

protocol INoteRepository {
    func saveContext() -> Result<Bool, Error>
    func insert(_ note: Note) -> Result<Bool, Error>
    func create() -> Note?
    func getAll() -> [Note]
}

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
}
