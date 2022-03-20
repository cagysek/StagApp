//
//  TeacherRepository.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 20.03.2022.
//

import Foundation
import CoreData


protocol ITeacherRepository {
    func saveContext() -> Result<Bool, Error>
    func insert(_ teacher: Teacher) -> Result<Bool, Error>
    func create() -> Teacher?
    func getTeacher() -> Teacher?
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


