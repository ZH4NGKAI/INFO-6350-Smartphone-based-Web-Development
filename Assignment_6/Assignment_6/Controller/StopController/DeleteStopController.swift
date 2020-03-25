//
//  DeleteStopController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class DeleteStopController: UIViewController {

    @IBOutlet weak var scheduleIDText: UITextField!
    
    @IBOutlet weak var stopNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteStop(_ sender: CustomButton) {
        guard let scheduleID = Int(scheduleIDText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct schedule ID", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        var schedule : Schedule!
        for train in AppDelegate.trains.trains {
            schedule = train.searchSchedule(id: scheduleID)
            if schedule != nil {
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
        guard let stopname = stopNameText.text, !stopname.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard schedule.deleteStop(name: stopname) else {
            let alertController = UIAlertController(title: "Alert:", message: "Stop \(stopname) not exists", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let alertController = UIAlertController(title: "Success:", message: "Stop \(stopname) deleted", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
