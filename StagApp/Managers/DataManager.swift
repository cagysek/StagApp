//
//  DataService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.01.2022.
//

import Foundation



struct DataManageer {
    
    let stagApiService: StagServiceImpl
    
        
    public func syncData() {
        self.syncUserData()
    }
    
    public func syncUserData() {
        
        CoreDataManager.deleteStudentInfo()
        
        self.stagApiService.fetchStudentInfo { result in
            switch result {
            case .success(let student):
                
                
//                let student = Student(context: coreDataService.container.viewContext)
//                student.studentNumber = studentInfo.studentId
//                student.lastname = studentInfo.lastname
//                student.name = studentInfo.firstname
                
                
                
//                self.coreDataService.container.viewContext.insert(student)
//                let result = try? self.coreDataService.container.viewContext.save()
                
                CoreDataManager.persistentContainer.viewContext.insert(student)
                let result = CoreDataManager.saveContext()
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
