//
//  SearchScheduleView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class SearchScheduleView: UIView{
    var searchScheduleView = UIView()
    var idInputField = UITextField()
    var arrivalYearField = UITextField()
    var arrivalMonthField = UITextField()
    var arrivalDayField = UITextField()
    var arrivalHourField = UITextField()
//    var arrivalMinuteField = UITextField()
    let displayScheduleView = DisplayScheduleView()
    var calendar = Calendar(identifier:Calendar.Identifier.iso8601)
    
    func initSearchSchedule(){
        searchScheduleView = UIView(frame: AppDelegate.homeViewRect)
        searchScheduleView.backgroundColor = UIColor.white
        searchScheduleView.isHidden = true
        AppDelegate.homeView.addSubview(searchScheduleView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 100, yValue: 150, width: 300, height: 30, text: "Search Schedule")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        searchScheduleView.addSubview(titleLabel)
        
        //Train id
        let idLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 250, width: 300, height: 30, text: "Line id: ")
        idLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        searchScheduleView.addSubview(idLabel)
        
        idInputField = InitializeView.createTextField(xValue: 59, yValue: 280, width: 300, height: 30, placeHolder: "Enter id", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        searchScheduleView.addSubview(idInputField)
        
        //arrival time
        let arrivalLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 500, width: 150, height: 30, text: "Arrival Time: ")
        arrivalLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        searchScheduleView.addSubview(arrivalLabel)
        
        arrivalYearField = InitializeView.createTextField(xValue: 59, yValue: 530, width: 120, height: 30, placeHolder: "Year", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        searchScheduleView.addSubview(arrivalYearField)
        
        arrivalMonthField = InitializeView.createTextField(xValue: 189, yValue: 530, width: 120, height: 30, placeHolder: "Month", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        searchScheduleView.addSubview(arrivalMonthField)
        
        arrivalDayField = InitializeView.createTextField(xValue: 59, yValue: 570, width: 120, height: 30, placeHolder: "Day", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        searchScheduleView.addSubview(arrivalDayField)
        
        arrivalHourField = InitializeView.createTextField(xValue: 189, yValue: 570, width: 120, height: 30, placeHolder: "Hour", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        searchScheduleView.addSubview(arrivalHourField)
        
//        arrivalMinuteField = InitializeView.createTextField(xValue: 279, yValue: 530, width: 100, height: 30, placeHolder: "Enter Minute", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
//        searchScheduleView.addSubview(arrivalMinuteField)
        
        //add button
        let searchBtn:UIButton = createButton(xValue: 83, yValue: 766, width: 250, height: 30, title:"Search Schedule", color: UIColor.purple, action: #selector(searchSchedule))
        searchScheduleView.addSubview(searchBtn)
        
        //back button
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Back", color: UIColor.purple, action: #selector(returnToMenu))
        searchScheduleView.addSubview(backBtn)
    }
    
    
    @objc func searchSchedule() {
        var schedules: Array<Schedule> = [Schedule]()
        guard let id = Int(idInputField.text!) else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Input value and should be Integer!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        guard let train = Train.searchTrain(id: id) else {
            let alert = UIAlertView()
            alert.title = "Error: "
            alert.message = "No.\(id) Train isn't existed in the system!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            idInputField.text = ""
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
        let arrivalTime = DateComponents(calendar: calendar, year: Int(arrivalYear)!, month: Int(arrivalMonth)!, day:Int(arrivalDay)!, hour: Int(arrivalHour)!)
        if !arrivalTime.isValidDate {
                   print("Not valid time, please check the input")
                   return
        }
        
        for schedule in train.schedules {
            guard arrivalTime.year == schedule.arrival?.year else {
                continue
            }
            guard arrivalTime.month == schedule.arrival?.month else {
                continue
            }
            guard arrivalTime.day == schedule.arrival?.day else {
                continue
            }
            guard abs(arrivalTime.hour! - schedule.arrival!.hour!) <= 1 else {
                continue
            }
            schedules.append(schedule)
        }
//        searchScheduleView.isHidden = true
        displaySchedules(schedules: schedules)
        idInputField.text = ""
        arrivalYearField.text = ""
        arrivalMonthField.text = ""
        arrivalDayField.text = ""
        arrivalHourField.text = ""
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
    
    @objc func returnToMenu(){
        searchScheduleView.isHidden = true
    }
    
    func displaySchedules(schedules: Array<Schedule>){
        displayScheduleView.initDisplaySchedule(schedules: schedules)
        displayScheduleView.displayScheduleView.isHidden = false
    }
}
