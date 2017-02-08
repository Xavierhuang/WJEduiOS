//
//  CoreDataStore.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore : NSObject {
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    
    override init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("Winsharesapp-iOS.sqlite")
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
    }
    
//    func fetchEntriesWithPredicate(_ predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], completionBlock: (([ManagedTodoItem]) -> Void)!) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
//        fetchRequest.predicate = predicate
//        fetchRequest.sortDescriptors = sortDescriptors
//        
//        managedObjectContext.perform {
//            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
//            let managedResults = queryResults! as! [ManagedTodoItem]
//            completionBlock(managedResults)
//        }
//    }
//    
//    func newTodoItem() -> ManagedTodoItem {
//        let newEntry = NSEntityDescription.insertNewObject(forEntityName: "TodoItem", into: managedObjectContext) as! ManagedTodoItem
//        
//        return newEntry
//    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch _ {
        }
    }
}

