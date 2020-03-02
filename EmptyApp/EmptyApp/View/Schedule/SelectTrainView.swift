//
//  SelectTrainView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit
class SelectTrainView: UIView{
    var selectTrainView = UIView()
    var idInputField = UITextField()
    let displayScheduleView = DisplayScheduleView()
    
    func initSelectTrain(){
        selectTrainView = UIView(frame: AppDelegate.homeViewRect)
        selectTrainView.backgroundColor = UIColor.white
        selectTrainView.isHidden = true
        AppDelegate.homeView.addSubview(selectTrainView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 100, yValue: 150, width: 300, height: 30, text: "Select Train")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        selectTrainView.addSubview(titleLabel)
        
        //id
        let idLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 250, width: 300, height: 30, text: "Train id: ")
        idLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        selectTrainView.addSubview(idLabel)
        
        idInputField = InitializeView.createTextField(xValue: 59, yValue: 280, width: 300, height: 30, placeHolder: "Enter id", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        selectTrainView.addSubview(idInputField)
        
        //add button
        let selectBtn:UIButton = createButton(xValue: 83, yValue: 766, width: 250, height: 30, title:"Select Train", color: UIColor.purple, action: #selector(selectTrain))
        selectTrainView.addSubview(selectBtn)
        
        //back button
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Back", color: UIColor.purple, action: #selector(returnToMenu))
        selectTrainView.addSubview(backBtn)
    }
    
    
    @objc func selectTrain() {
        guard let id = Int(idInputField.text!) else {
//            let alertController = UIAlertController(title: "iOScreator", message:
//                "Hello, world!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//            self.present(alertController, animated: true, completion: nil)
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "Input Integer value!"
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
//        selectTrainView.isHidden = true
        displaySchedules(train: train)
        idInputField.text = ""
        
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
        selectTrainView.isHidden = true
    }
    
    func displaySchedules(train: Train){
        displayScheduleView.initDisplaySchedule(schedules: train.schedules)
        displayScheduleView.displayScheduleView.isHidden = false
    }
}
