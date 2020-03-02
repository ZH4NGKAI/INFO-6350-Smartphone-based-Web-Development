//
//  AddScheduleView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class AddScheduleView: UIView {
    var addScheduleView = UIView()
    var lineIdTextField = UITextField()
    var arrivalYearField = UITextField()
    var arrivalMonthField = UITextField()
    var arrivalDayField = UITextField()
    var arrivalHourField = UITextField()
    var arrivalMinuteField = UITextField()
    var departureYearField = UITextField()
    var departureMonthField = UITextField()
    var departureDayField = UITextField()
    var departureHourField = UITextField()
    var departureMinuteField = UITextField()
    var calendar = Calendar(identifier:Calendar.Identifier.iso8601)
    
    func initAddSchedule(){
        addScheduleView = UIView(frame: AppDelegate.homeViewRect)
        addScheduleView.backgroundColor = UIColor.white
        addScheduleView.isHidden = true
        AppDelegate.homeView.addSubview(addScheduleView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 80, yValue: 150, width: 300, height: 30, text: "Add Schedules")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        addScheduleView.addSubview(titleLabel)
        
        //Line id
        let lineLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 250, width: 100, height: 30, text: "Line id: ")
        lineLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        addScheduleView.addSubview(lineLabel)
        
        lineIdTextField = InitializeView.createTextField(xValue: 59, yValue: 280, width: 300, height: 30, placeHolder: "Line id", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(lineIdTextField)
        
        //arrival time
        let arrivalLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 360, width: 150, height: 30, text: "Arrival Time: ")
        arrivalLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        addScheduleView.addSubview(arrivalLabel)
        
        arrivalYearField = InitializeView.createTextField(xValue: 59, yValue: 390, width: 80, height: 30, placeHolder: "Year", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(arrivalYearField)
        
        arrivalMonthField = InitializeView.createTextField(xValue: 169, yValue: 390, width: 80, height: 30, placeHolder: "Month", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(arrivalMonthField)
        
        arrivalDayField = InitializeView.createTextField(xValue: 279, yValue: 390, width: 80, height: 30, placeHolder: "Day", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(arrivalDayField)
        
        arrivalHourField = InitializeView.createTextField(xValue: 169, yValue: 430, width: 80, height: 30, placeHolder: "Hour", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(arrivalHourField)
        
        arrivalMinuteField = InitializeView.createTextField(xValue: 279, yValue: 430, width: 80, height: 30, placeHolder: "Minute", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(arrivalMinuteField)
        
        
        //departure time
        let departureLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 500, width: 150, height: 30, text: "Departure Time: ")
        departureLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        addScheduleView.addSubview(departureLabel)
        
        departureYearField = InitializeView.createTextField(xValue: 59, yValue: 530, width: 80, height: 30, placeHolder: "Year", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(departureYearField)
        
        departureMonthField = InitializeView.createTextField(xValue: 169, yValue: 530, width: 80, height: 30, placeHolder: "Month", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(departureMonthField)
        
        departureDayField = InitializeView.createTextField(xValue: 279, yValue: 530, width: 80, height: 30, placeHolder: "Day", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(departureDayField)
        
        departureHourField = InitializeView.createTextField(xValue: 169, yValue: 570, width: 80, height: 30, placeHolder: "Hour", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(departureHourField)
        
        departureMinuteField = InitializeView.createTextField(xValue: 279, yValue: 570, width: 80, height: 30, placeHolder: "Minute", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addScheduleView.addSubview(departureMinuteField)
        
        //add button
        let addBtn:UIButton = createButton(xValue: 83, yValue: 756, width: 250, height: 30, title:"Add Schedule", color: UIColor.purple, action: #selector(addSchedule))
        addScheduleView.addSubview(addBtn)
        
        //return button
        let returnBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Return to Menu", color: UIColor.purple, action: #selector(returnToMenu))
        addScheduleView.addSubview(returnBtn)
    }
    
    func createButton(xValue:Double, yValue:Double,width:Double,height:Double,title:String,color:UIColor,action:Selector) -> UIButton {
       let button: UIButton = UIButton(type:.roundedRect)
       button.frame = CGRect(x:xValue,y:yValue,width:width,height:height)
       button.layer.cornerRadius = CGFloat(height / 2)
       button.setTitle(title, for: UIControl.State.normal)
       button.backgroundColor = color
       button.setTitleColor(UIColor.white,for: UIControl.State.normal)
       button.addTarget(self, action: action, for: .touchUpInside)
       button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(height-10))
       return button
    }
    
    @objc func addSchedule(){
        guard let id = Int(lineIdTextField.text!) else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let arrivalYear = arrivalYearField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let arrivalMonth = arrivalMonthField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let arrivalDay = arrivalDayField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let arrivalHour = arrivalHourField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let arrivalMinute = arrivalMinuteField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let departureYear = departureYearField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let departureMonth = departureMonthField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let departureDay = departureDayField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let departureHour = departureHourField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let departureMinute = departureMinuteField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Please input text field!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let train = Train.searchTrain(id: id) else {
            let alert = UIAlertView()
            alert.title = "Error: "
            alert.message = "No.\(id) train not found!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        let arrivalTime = DateComponents(calendar: calendar, year: Int(arrivalYear)!, month: Int(arrivalMonth)!, day:Int(arrivalDay)!, hour: Int(arrivalHour)!, minute: Int(arrivalMinute)!)
        let departureTime = DateComponents(calendar: calendar, year: Int(departureYear)!, month: Int(departureMonth)!, day:Int(departureDay)!, hour: Int(departureHour)!, minute: Int(departureMinute)!)
        if !arrivalTime.isValidDate || !departureTime.isValidDate {
            print("Not valid time, please check the input")
            return
        }
        train.schedules.append(Schedule(arrival: arrivalTime, departure: departureTime))
        let alert = UIAlertView()
        alert.title = "Success: "
        alert.message = "Schedule is added in No.\(id) train!"
        alert.addButton(withTitle: "Got it!")
        alert.show()
        lineIdTextField.text = ""
        arrivalYearField.text = ""
        arrivalMonthField.text = ""
        arrivalDayField.text = ""
        arrivalHourField.text = ""
        arrivalMinuteField.text = ""
        departureYearField.text = ""
        departureMonthField.text = ""
        departureDayField.text = ""
        departureHourField.text = ""
        departureMinuteField.text = ""
    }
    
    @objc func returnToMenu(){
        addScheduleView.isHidden = true
    }
    
}
