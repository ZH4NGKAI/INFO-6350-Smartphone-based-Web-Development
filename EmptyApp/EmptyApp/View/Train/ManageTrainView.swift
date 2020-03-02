//
//  TrainView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//
import UIKit

class ManageTrainView: UIView {
    var manageTrainView = UIView()
    let addTrainView = AddTrainView()
    let deleteTrainView = DeleteTrainView()
    let displayTrainView = DisplayTrainView()
    
    func initTrainView(){
        manageTrainView = UIView(frame: AppDelegate.homeViewRect)
        manageTrainView.backgroundColor = UIColor.white
        manageTrainView.isHidden = true
        AppDelegate.homeView.addSubview(manageTrainView)
        
        let MBTALabel: UILabel = InitializeView.createLabel(xValue: 150, yValue: 160, width: 200, height: 30, text:"MBTA")
        MBTALabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        manageTrainView.addSubview(MBTALabel)
        
        let addTrainBtn: UIButton = createButton(xValue: 107, yValue: 300, width: 200, height: 30, title: "Add Train", color: UIColor.purple, action: #selector(showAddTrainView))
        manageTrainView.addSubview(addTrainBtn)
        
        let deleteTrainBtn:UIButton = createButton(xValue: 107, yValue: 380, width: 200, height: 30, title: "Delete Train", color: UIColor.purple, action: #selector(showDeleteTrainView))
        manageTrainView.addSubview(deleteTrainBtn)
        
        let displayTrainBtn:UIButton = createButton(xValue: 107, yValue: 460, width: 200, height: 30, title: "Display Train", color: UIColor.purple, action: #selector(showDisplayTrainView))
        manageTrainView.addSubview(displayTrainBtn)
        
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title: "Back", color: UIColor.purple, action: #selector(showPreviousView))
        manageTrainView.addSubview(backBtn)
        
        addTrainView.initAddTrain()
        deleteTrainView.initDeleteTrain()
        displayTrainView.initDisplayTrain()
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
    
    //show add train view
    @objc func showAddTrainView() {
        addTrainView.addTrainView.isHidden = false
    }
    //show delete train view
    @objc func showDeleteTrainView() {
        deleteTrainView.deleteTrainView.isHidden = false
    }
    
    @objc func showDisplayTrainView() {
        displayTrainView.displayTrainView.isHidden = false
    }
    
    @objc func showPreviousView() {
        manageTrainView.isHidden = true
    }
}
