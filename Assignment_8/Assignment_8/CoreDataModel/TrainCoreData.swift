//
//  TrainCoreData.swift
//  Assignment_8
//
//  Created by mac on 3/28/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
import CoreData

class TrainCoreData {
    func getTrains(managedContext:NSManagedObjectContext) -> NSFetchedResultsController<Train>{
    
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Train")
            let sortName = NSSortDescriptor(key: "line", ascending: true)
            fetchRequest.sortDescriptors = [sortName]
    
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    
            do{
                try fetchedResultsController.performFetch()
            }catch let error as NSError{
                print("Error :\(error.userInfo)")
            }
            return fetchedResultsController as! NSFetchedResultsController<Train>
    }
    func saveTrain(line: String, image: Data, managedContext: NSManagedObjectContext) -> Train{
        let trainEntity = NSEntityDescription.entity(forEntityName: "Train", in: managedContext)
        let train = NSManagedObject.init(entity: trainEntity!, insertInto: managedContext)
        train.setValue(line, forKey: "line")
        train.setValue(image, forKey: "image")
        
        saveContext(managedContext: managedContext)
        return train as! Train
    }
    
    func saveContext (managedContext:NSManagedObjectContext) {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func searchTrain(line:String,managedContext:NSManagedObjectContext) -> Bool{
            let fetchedResultsController = getTrains(managedContext: managedContext)
            let trainList = fetchedResultsController.fetchedObjects!
            for train in trainList{
                if(line == train.line){
                    return false
                }
            }
            return true
        }
}
