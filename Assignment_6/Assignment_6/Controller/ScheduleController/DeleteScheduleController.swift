//
//  DeleteScheduleController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class DeleteScheduleController: UIViewController {

    @IBOutlet weak var scheduleIDText: UITextField!
    @IBOutlet weak var trainIDText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func deleteSchedule(_ sender: CustomButton) {
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
        guard let scheduleID = Int(scheduleIDText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct schedule ID", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard train.deleteSchedule(id: scheduleID) else {
            let alertController = UIAlertController(title: "Alert:", message: "Schedule \(scheduleID) not exists in Train \(trainID)", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let alertController = UIAlertController(title: "Success:", message: "Delete schedule \(scheduleID) successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        trainIDText.text = ""
        scheduleIDText.text = ""
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
