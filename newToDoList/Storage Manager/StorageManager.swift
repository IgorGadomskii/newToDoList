//
//  StorageManager.swift
//  newToDoList
//
//  Created by Macbook on 27.08.2022.
//

import Foundation
import UIKit
import CoreData

class StorageManager {
    
    static var shared = StorageManager()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "newToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
          return persistentContainer.viewContext
      }()
    
    var taskList: [NewTask] = []
}

extension StorageManager {
    
    
    func fetchData(completion: (Result<[NewTask], Error>) -> Void) {
        let fetchRequest = NewTask.fetchRequest()
        do {
            taskList = try context.fetch(fetchRequest)
            completion(.success(taskList))
        } catch let error {
            completion(.failure(error))
            print("Failed to fetch data", error)
        }
    }
    
    func save(_ taskName: String, _ taskDate: Date, completion: (NewTask) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "NewTask", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? NewTask else { return }
        task.name = taskName
        task.date = taskDate
        completion(task)
        saveContext()
    }
    
    func delete(_ task: NewTask) {
        context.delete(task)
        saveContext()
    }
    
    func edit(_ taskName: String,_  taskDate: Date, for editedTask: NewTask){
        editedTask.name = taskName
        editedTask.date = taskDate
        saveContext()
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
