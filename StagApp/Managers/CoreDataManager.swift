//
//  CoreDataService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.01.2022.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {

    private init(){}
    
    public static func getContext () -> NSManagedObjectContext {
        return CoreDataManager.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
            //The container that holds both data model entities
            let container = NSPersistentContainer(name: "CoreDataModel")

            

            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                
                print(container.persistentStoreCoordinator.persistentStores.first?.url)
                
                if let error = error as NSError? {


                    //TODO: - Add Error Handling for Core Data

                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }


            })
            return container
    }()
    
    
    
    // MARK: CRUD functions
    public static func saveContext() {
        let context =  self.getContext()
        
        if (context.hasChanges) {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public static func getStudentInfo() -> Student? {
        let request = NSFetchRequest<Student>(entityName: "Student")
        
        do {
            let data = try self.getContext().fetch(request)
            
            return data.first
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return nil
    }
    
    
    public static func deleteStudentInfo() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            let deleteAll = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            try self.getContext().execute(deleteAll)
            self.saveContext()
        } catch {
            
        }
    }

    
}
