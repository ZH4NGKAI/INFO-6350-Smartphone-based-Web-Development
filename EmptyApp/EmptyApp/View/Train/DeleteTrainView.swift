//
//  DeleteTrainView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit
class DeleteTrainView: UIView{
    var deleteTrainView = UIView()
    var idInputField = UITextField()
    @objc let displayTrain = DisplayTrainView()
    
    func initDeleteTrain(){
        deleteTrainView = UIView(frame: AppDelegate.homeViewRect)
        deleteTrainView.backgroundColor = UIColor.white
        deleteTrainView.isHidden = true
        AppDelegate.homeView.addSubview(deleteTrainView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 100, yValue: 150, width: 300, height: 30, text: "Delete Train")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        deleteTrainView.addSubview(titleLabel)
        
        //id
        let idLabel: UILabel = InitializeView.createLabel(xValue: 59, yValue: 250, width: 300, height: 30, text: "Train id: ")
        idLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        deleteTrainView.addSubview(idLabel)
        
        idInputField = InitializeView.createTextField(xValue: 59, yValue: 280, width: 300, height: 30, placeHolder: "Enter id", textAlignment: NSTextAlignment.center, textColor: UIColor.blue)
        deleteTrainView.addSubview(idInputField)
        
        //add button
        let displayBtn:UIButton = createButton(xValue: 83, yValue: 716, width: 250, height: 30, title:"Display Train", color: UIColor.purple, action: #selector(displayTrains))
        deleteTrainView.addSubview(displayBtn)
        
        let deleteBtn:UIButton = createButton(xValue: 83, yValue: 766, width: 250, height: 30, title:"Delete Train", color: UIColor.purple, action: #selector(deleteTrain))
        deleteTrainView.addSubview(deleteBtn)
        
        //back button
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Back", color: UIColor.purple, action: #selector(returnToMenu))
        deleteTrainView.addSubview(backBtn)
    }
    
    
    @objc func deleteTrain() {
        let id = idInputField.text!
        if id == "" {
//            let alertController = UIAlertController(title: "iOScreator", message:
//                "Hello, world!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//            self.present(alertController, animated: true, completion: nil)
            let alert = UIAlertView()
            alert.title = "Alert: "
            alert.message = "You need to input the value!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
        }else if !Train.deleteTrain(id: Int(id) ?? -1) {
            let alert = UIAlertView()
            alert.title = "Error: "
            alert.message = "No.\(id) Train isn't existed in the system!"
            alert.addButton(withTitle: "Edit it!")
            alert.show()
            idInputField.text = ""
        }else {
            let alert = UIAlertView()
            alert.title = "Success: "
            alert.message = "No.\(id) Train is deleted in the system!"
            alert.addButton(withTitle: "Got it!")
            alert.show()
            deleteTrainView.isHidden = true
            displayTrains()
            idInputField.text = ""
        }
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
        deleteTrainView.isHidden = true
    }
    
    @objc func displayTrains(){
        displayTrain.initDisplayTrain()
        displayTrain.displayTrainView.isHidden = false
    }
}
