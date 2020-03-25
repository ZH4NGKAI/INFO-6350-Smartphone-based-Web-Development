//
//  DisplayTrainController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class DisplayTrainController: UIViewController {

    @IBOutlet weak var displayTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        var result = ""
        for train in AppDelegate.trains.trains{
            result += "Train ID: \(train.id) \n"
            result += "Line Name: \(train.line) \n"
            result += "Source Station: \(train.source?.name ?? "") \n"
            result += "Destination Station: \(train.destination?.name ?? "") \n"
            result += "************************************************** \n"
            for schedule in train.schedules {
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
            }
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
