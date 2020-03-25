//
//  SearchTrainController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class SearchTrainController: UIViewController {

    @IBOutlet weak var trainTextView: UITextView!
    @IBOutlet weak var trainIDText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func searchTrain(_ sender: CustomButton) {
        guard let trainID = Int(trainIDText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct train ID", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let train = AppDelegate.trains.searchTrain(id: trainID) else {
            let alertController = UIAlertController(title: "Alert:", message: "Train \(trainID) not exists", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        var result = ""
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
        trainTextView.text = result
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
