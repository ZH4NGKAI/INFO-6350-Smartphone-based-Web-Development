//
//  ScheduleViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CoreData

class ScheduleDetailViewController: UIViewController {
    var train = Train()
    var schedule: Schedule?
    var btnTitle = ""
    var managedContext : NSManagedObjectContext!
    var scheduleCoreData = ScheduleCoreData()
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var arrivalTime: UIDatePicker!
    @IBOutlet weak var departureTime: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle(btnTitle, for:.normal)
        stopBtn.isEnabled = false
        if title == "Edit Schedule Details" {
            stopBtn.isEnabled = true
            arrivalTime.date = schedule!.arrival!
            departureTime.date = schedule!.departure!
        }
        let app = UIApplication.shared.delegate as! AppDelegate
        managedContext = app.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createOrUpdate(_ sender: UIButton) {
        
        let arrival = arrivalTime.date
        let departure = departureTime.date
        guard arrival.compare(departure) != .orderedDescending else {
            let alertController = UIAlertController(title: "Alert:", message: "Departure time should be later than arrival time", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if title == "Edit Schedule Details" {
            schedule?.arrival = arrival
            schedule?.departure = departure
            scheduleCoreData.saveContext(managedContext: managedContext)
        }
        else {
            schedule = scheduleCoreData.saveSchedule(train: train, arrival: arrival, departure: departure, managedContext: managedContext)
            
        }
        let alertController = UIAlertController(title: "Success:", message: "Schedule Added/Updated Successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        stopBtn.isEnabled = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SStopTableSegue"{
        //            let indexPath = tableView.indexPathForSelectedRow
            let vc = segue.destination as! SStopTableViewController
            vc.title = "Schedule Stop Table"
            vc.schedule = schedule
        }
    }
    

}
