//
//  ScheduleCoreData.swift
//  Assignment_8
//
//  Created by mac on 3/28/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
import CoreData

class ScheduleCoreData {
    func getSchedules(train: Train, managedContext:NSManagedObjectContext) -> NSFetchedResultsController<Schedule>{

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Schedule")
            let sortName = NSSortDescriptor(key: "id", ascending: true)
            fetchRequest.sortDescriptors = [sortName]
            fetchRequest.predicate = NSPredicate(format: "train.line = %@", "<train>")
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    
            do{
                try fetchedResultsController.performFetch()
            }catch let error as NSError{
                print("Error :\(error.userInfo)")
            }
            return fetchedResultsController as! NSFetchedResultsController<Schedule>
    }
    func saveSchedule(train: Train, arrival: Date, departure: Date, managedContext: NSManagedObjectContext) -> Schedule{
    
        let scheduleEntity = NSEntityDescription.entity(forEntityName: "Schedule", in: managedContext)
        let schedule = NSManagedObject.init(entity: scheduleEntity!, insertInto: managedContext)
        let recordID = train.schedules!.count + 1
        schedule.setValue(recordID, forKey: "id")
        schedule.setValue(arrival, forKey: "arrival")
        schedule.setValue(departure, forKey: "departure")
        schedule.setValue(train, forKey: "train")
        
        saveContext(managedContext: managedContext)
        return schedule as! Schedule

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
    
    //    func FindBooking(booking:Booking,managedContext:NSManagedObjectContext) -> Booking?{
    //        let fetchedResultsController = getBookings(managedContext: managedContext)
    //        let bookingList = fetchedResultsController.fetchedObjects!
    //        for Booking in bookingList{
    //            if(Booking == booking){
    //                return Booking
    //            }
    //        }
    //        return nil
    //    }
}
