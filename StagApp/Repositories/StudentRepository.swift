//
//  StudentRepository.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 20.03.2022.
//

import Foundation
import CoreData

protocol IStudentRepository {
    func saveContext() -> Result<Bool, Error>
    func insert(_ student: Student) -> Result<Bool, Error>
    func create() -> Student?
    func getStudent() -> Student?
}


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
