//
//  StopCoreData.swift
//  Assignment_9
//
//  Created by mac on 3/28/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
import CoreData

class StopCoreData {
    func getStops(managedContext:NSManagedObjectContext) -> NSFetchedResultsController<Stop>{
    
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stop")
            let sortName = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortName]
    
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    
            do{
                try fetchedResultsController.performFetch()
            }catch let error as NSError{
                print("Error :\(error.userInfo)")
            }
            return fetchedResultsController as! NSFetchedResultsController<Stop>
    }
    func saveStop(name: String, latitude: Double, longditude: Double, address: String, managedContext: NSManagedObjectContext) -> Stop{
    
        let stopEntity = NSEntityDescription.entity(forEntityName: "Stop", in: managedContext)
        let stop = NSManagedObject.init(entity: stopEntity!, insertInto: managedContext)
        stop.setValue(name, forKey: "name")
        stop.setValue(latitude, forKey: "latitude")
        stop.setValue(longditude, forKey: "longitude")
        stop.setValue(address, forKey: "address")
        
        saveContext(managedContext: managedContext)
        return stop as! Stop

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
    
        func searchStop(name:String, managedContext:NSManagedObjectContext) -> Stop? {
            let fetchedResultsController = getStops(managedContext: managedContext)
            let stopList = fetchedResultsController.fetchedObjects!
            for stop in stopList{
                if(stop.name == name){
                    return stop
                }
            }
            return nil
        }
}
