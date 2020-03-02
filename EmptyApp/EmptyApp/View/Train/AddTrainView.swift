//
//  AddTrainView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class AddTrainView: UIView {
    var addTrainView = UIView()
    var nameInputField = UITextField()
    
    let displayTrainView = DisplayTrainView()
    
    func initAddTrain(){
        addTrainView = UIView(frame: AppDelegate.homeViewRect)
        addTrainView.backgroundColor = UIColor.white
        addTrainView.isHidden = true
        AppDelegate.homeView.addSubview(addTrainView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 80, yValue: 150, width: 300, height: 30, text: "Add Train Details")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        addTrainView.addSubview(titleLabel)
        
        //name
        let nameLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 250, width: 50, height: 30, text: "Name: ")
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        addTrainView.addSubview(nameLabel)
        
        nameInputField = InitializeView.createTextField(xValue: 59, yValue: 280, width: 300, height: 30, placeHolder: "Enter Name", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        addTrainView.addSubview(nameInputField)
        
        //add button
        let addBtn:UIButton = createButton(xValue: 83, yValue: 756, width: 250, height: 30, title:"Add Train", color: UIColor.purple, action: #selector(addTrain))
        addTrainView.addSubview(addBtn)
        
        //return button
        let returnBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Return to Menu", color: UIColor.purple, action: #selector(returnToMenu))
        addTrainView.addSubview(returnBtn)
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
    
    @objc func addTrain(){
        guard let name = nameInputField.text else {
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "No train to add!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            return
        }
        let newTrain = Train(line: name)
        AppDelegate.TrainDirectory.append(newTrain)
        let alert = UIAlertView()
        alert.title = "Success: "
        alert.message = "\(name) is added in the system!"
        alert.addButton(withTitle: "Got it!")
        alert.show()
        displayTrains()
        nameInputField.text = ""
    }
    
    @objc func returnToMenu(){
        addTrainView.isHidden = true
    }
    
    func displayTrains(){
        addTrainView.isHidden = true
        displayTrainView.initDisplayTrain()
        displayTrainView.displayTrainView.isHidden = false
    }
    
}
