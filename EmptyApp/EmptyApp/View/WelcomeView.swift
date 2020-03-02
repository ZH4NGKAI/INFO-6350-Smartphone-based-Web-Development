//
//  WelcomeView.swift
//  EmptyApp
//
//  Created by mac on 2/29/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    let manageTrainView = ManageTrainView()
    let manageScheduleView = ManageScheduleView()
    func initWelcome(){
         //welcome words
        let MBTALabel: UILabel = InitializeView.createLabel(xValue: 150, yValue: 160, width: 200, height: 30, text:"MBTA")
        MBTALabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        AppDelegate.homeView.addSubview(MBTALabel)
        let cityLabel: UILabel = InitializeView.createLabel(xValue:150,yValue:210,width:314,height:50,text:"Boston")
        cityLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
        AppDelegate.homeView.addSubview(cityLabel)
         
         //functionality buttons on home page
        let manageTrainBtn:UIButton = createButton(xValue: 107, yValue: 350, width: 200, height: 30, title: "Manage Train", color:UIColor.purple,action:#selector(showTrainView))
        AppDelegate.homeView.addSubview(manageTrainBtn)
        
        let manageScheduleBtn:UIButton = createButton(xValue: 107, yValue: 450, width: 200, height: 30, title: "Manage Schedule", color:UIColor.purple,action:#selector(showScheduleView))
        AppDelegate.homeView.addSubview(manageScheduleBtn)
        
        manageTrainView.initTrainView()
        manageScheduleView.initScheduleView()
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

     
     //show manage train view
    @objc func showTrainView() {
        manageTrainView.manageTrainView.isHidden = false
     }
    //show manage schedule view
    @objc func showScheduleView() {
        manageScheduleView.manageScheduleView.isHidden = false
     }
}
