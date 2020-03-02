//
//  DisplayScheduleView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class DisplayScheduleView: UIView{
    var displayScheduleView = UIView()
    var trainListView = UITextView()
    
    func initDisplaySchedule(schedules: Array<Schedule>){
        displayScheduleView = UIView(frame: AppDelegate.homeViewRect)
        displayScheduleView.backgroundColor = UIColor.white
        displayScheduleView.isHidden = true
        AppDelegate.homeView.addSubview(displayScheduleView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 80, yValue: 150, width: 300, height: 30, text: "Display Schedules")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        displayScheduleView.addSubview(titleLabel)
        
        //show list
        var result = ""
        for item in schedules {
            result += "Schedule Id: \(item.id) \n"
            result += "Arrival Time: \(item.arrival!.year!)-\(item.arrival!.month!)-\(item.arrival!.day!)-\(item.arrival!.hour!):\(item.arrival!.minute!)\n"
            result += "Depature Time:\(item.departure!.year!)-\(item.departure!.month!)-\(item.departure!.day!)-\(item.departure!.hour!):\(item.departure!.minute!) \n"
            result += "----------------------------------- \n"
        }
        trainListView = InitializeView.createTextView(xValue: 50, yValue: 230, width: 300, height: 500)
        trainListView.text = result
        displayScheduleView.addSubview(trainListView)
        
        //back button
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Back", color: UIColor.purple, action: #selector(returnToMenu))
        displayScheduleView.addSubview(backBtn)
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
        displayScheduleView.isHidden = true
    }
    
}

