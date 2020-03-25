//
//  SearchStopController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class SearchStopController: UIViewController {

    @IBOutlet weak var stopNameText: UITextField!
    @IBOutlet weak var displayTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func searchStop(_ sender: CustomButton) {
        guard let stopName = stopNameText.text, !stopName.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        var result = ""
        for train in AppDelegate.trains.trains{
            for schedule in train.schedules {
                for stop in schedule.stops {
                    if stop.name == stopName {
                        result += "Train ID: \(train.id) \n"
                        result += "Line Name: \(train.line) \n"
                        result += "------------------------------------------------- \n"
                        
                        result += "Schedule ID: \(schedule.id) \n"
                        result += "------------------------------------------------- \n"
                        result += "Stop Name: \(stop.name ?? "") \n"
                        result += "Stop Latitude: \(String(stop.location!.latitude)) \n"
                        result += "Stop Longitude: \(String(stop.location!.longitude)) \n"
                        result += "Stop Address: \(stop.address ?? "") \n"
                        result += "************************************************** \n"
                    }
                }
            }
        }
        if result == "" {
            
            result += "No Existed \(stopName) Stop"
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
