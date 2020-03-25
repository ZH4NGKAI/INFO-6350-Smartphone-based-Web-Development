//
//  UpdateScheduleController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class UpdateScheduleController: UIViewController {
    let calendar = Calendar(identifier:Calendar.Identifier.iso8601)
    @IBOutlet weak var scheduleIDText: UITextField!
    @IBOutlet weak var arrivalYearText: UITextField!
    
    @IBOutlet weak var arrivalMonthText: UITextField!
    
    @IBOutlet weak var arrivalDayText: UITextField!
    
    @IBOutlet weak var arrivalHourText: UITextField!
    
    @IBOutlet weak var arrivalMinuteText: UITextField!
    
    @IBOutlet weak var departureYearText: UITextField!
    
    @IBOutlet weak var departureMonthText: UITextField!
    
    @IBOutlet weak var departureDayText: UITextField!
    
    @IBOutlet weak var departureHourText: UITextField!
    
    @IBOutlet weak var departureMinuteText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func udpateSchedule(_ sender: CustomButton) {
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
        guard let arrivalYear = Int(arrivalYearText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct arrival year", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let arrivalMonth = Int(arrivalMonthText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct arrival month", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let arrivalDay = Int(arrivalDayText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct arrival day", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let arrivalHour = Int(arrivalHourText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct arrival hour", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let arrivalMinute = Int(arrivalMinuteText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct arrival minute", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let departureYear = Int(departureYearText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct departure year", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let departureMonth = Int(departureMonthText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct departure month", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let departureDay = Int(departureDayText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct departure day", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let departureHour = Int(departureHourText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct departure hour", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let departureMinute = Int(departureMinuteText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct departure minute", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let arrivalTime = DateComponents(calendar: calendar, year: Int(arrivalYear), month: Int(arrivalMonth), day:Int(arrivalDay), hour: Int(arrivalHour), minute: Int(arrivalMinute))
        let departureTime = DateComponents(calendar: calendar, year: Int(departureYear), month: Int(departureMonth), day:Int(departureDay), hour: Int(departureHour), minute: Int(departureMinute))
        guard arrivalTime.isValidDate && departureTime.isValidDate else{
            let alertController = UIAlertController(title: "Alert:", message: "Invalid Time", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard Calendar.current.date(from: arrivalTime)?.compare(Calendar.current.date(from:departureTime)!) != .orderedDescending else {
            let alertController = UIAlertController(title: "Alert:", message: "Departure time should be later than arrival time", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        schedule.arrival = arrivalTime
        schedule.departure = departureTime
        let alertController = UIAlertController(title: "Success:", message: "Schedule updated successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        scheduleIDText.text = ""
        arrivalYearText.text = ""
        arrivalMonthText.text = ""
        arrivalDayText.text = ""
        arrivalHourText.text = ""
        arrivalMinuteText.text = ""
        departureYearText.text = ""
        departureMonthText.text = ""
        departureDayText.text = ""
        departureHourText.text = ""
        departureMinuteText.text = ""
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


