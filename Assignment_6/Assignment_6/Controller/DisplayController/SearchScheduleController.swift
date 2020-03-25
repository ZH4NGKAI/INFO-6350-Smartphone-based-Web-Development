//
//  SearchScheduleController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class SearchScheduleController: UIViewController {

    @IBOutlet weak var scheduleIDText: UITextField!
    @IBOutlet weak var displayTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func searchSchedule(_ sender: CustomButton) {
        guard let scheduleID = Int(scheduleIDText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct schedule ID", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        var itrain: Train!
        var schedule : Schedule!
        for train in AppDelegate.trains.trains {
            schedule = train.searchSchedule(id: scheduleID)
            if schedule != nil {
                itrain = train
                break
            }
        }
        guard schedule != nil else {
            let alertController = UIAlertController(title: "Alert:", message: "Schedule \(scheduleID) not exists", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        var result = ""
        result += "Train ID: \(itrain.id) \n"
        result += "Line Name: \(itrain.line) \n"
        result += "Source Station: \(itrain.source?.name ?? "") \n"
        result += "Destination Station: \(itrain.destination?.name ?? "") \n"
        result += "************************************************** \n"
        
        result += "Schedule ID: \(schedule.id) \n"
        result += "Arrival Time: \(dateFormatter.string(from: Calendar.current.date(from: schedule.arrival!)!)) \n"
        
        result += "Departure Time: \(dateFormatter.string(from: Calendar.current.date(from: schedule.departure!)!)) \n"
        result += "------------------------------------------------- \n"
        for stop in schedule.stops {
            result += "Stop Name: \(stop.name ?? "") \n"
            result += "Stop Latitude: \(String(stop.location!.latitude)) \n"
            result += "Stop Longitude: \(String(stop.location!.longitude)) \n"
            result += "Stop Address: \(stop.address ?? "") \n"
            result += "------------------------------------------------- \n"
        }
        
        displayTextView.text = result
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
