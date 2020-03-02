//
//  DisplayTrainView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class DisplayTrainView: UIView{
    var displayTrainView = UIView()
    var trainListView = UITextView()
    
    func initDisplayTrain(){
        displayTrainView = UIView(frame: AppDelegate.homeViewRect)
        displayTrainView.backgroundColor = UIColor.white
        displayTrainView.isHidden = true
        AppDelegate.homeView.addSubview(displayTrainView)
        
        let titleLabel: UILabel = InitializeView.createLabel(xValue: 80, yValue: 150, width: 300, height: 30, text: "Display All Trains")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        displayTrainView.addSubview(titleLabel)
        
        //show list
        var result = ""
        for item in AppDelegate.TrainDirectory{
            result += "Train Id: \(item.id) \n"
            result += "Line Name: \(item.line) \n"
            result += "----------------------------------- \n"
        }
        trainListView = InitializeView.createTextView(xValue: 50, yValue: 230, width: 300, height: 500)
        trainListView.text = result
        displayTrainView.addSubview(trainListView)
        
        //return button
        let returnBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title:"Return to Menu", color: UIColor.purple, action: #selector(returnToMenu))
        displayTrainView.addSubview(returnBtn)
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
        displayTrainView.isHidden = true
    }
    
}
