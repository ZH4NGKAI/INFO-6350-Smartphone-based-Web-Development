//
//  ScheduleView.swift
//  EmptyApp
//
//  Created by mac on 3/1/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation
import UIKit

class ManageScheduleView: UIView {
    var manageScheduleView = UIView()
    let addScheduleView = AddScheduleView()
    let deleteScheduleView = DeleteScheduleView()
    let selectTrainView = SelectTrainView()
    let searchScheduleView = SearchScheduleView()
    
    func initScheduleView(){
        manageScheduleView = UIView(frame: AppDelegate.homeViewRect)
        manageScheduleView.backgroundColor = UIColor.white
        manageScheduleView.isHidden = true
        AppDelegate.homeView.addSubview(manageScheduleView)
        
        let MBTALabel: UILabel = InitializeView.createLabel(xValue: 150, yValue: 160, width: 200, height: 30, text:"MBTA")
        MBTALabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        manageScheduleView.addSubview(MBTALabel)
        
        let addScheduleBtn: UIButton = createButton(xValue: 107, yValue: 300, width: 200, height: 30, title: "Add Schedule", color: UIColor.purple, action: #selector(showAddScheduleView))
        manageScheduleView.addSubview(addScheduleBtn)
        
        let deleteScheduleBtn:UIButton = createButton(xValue: 107, yValue: 380, width: 200, height: 30, title: "Delete Schedule", color: UIColor.purple, action: #selector(showDeleteScheduleView))
        manageScheduleView.addSubview(deleteScheduleBtn)
        
        let selectTrainBtn:UIButton = createButton(xValue: 107, yValue: 460, width: 200, height: 30, title: "Select Train", color: UIColor.purple, action: #selector(showSelectTrainView))
        manageScheduleView.addSubview(selectTrainBtn)
        
        let searchScheduleBtn:UIButton = createButton(xValue: 107, yValue: 540, width: 200, height: 30, title: "Search Schedule", color: UIColor.purple, action: #selector(showSearchScheduleView))
        manageScheduleView.addSubview(searchScheduleBtn)
        
        let backBtn:UIButton = createButton(xValue: 83, yValue: 816, width: 250, height: 30, title: "Back", color: UIColor.purple, action: #selector(showPreviousView))
        manageScheduleView.addSubview(backBtn)
        
        addScheduleView.initAddSchedule()
        deleteScheduleView.initDeleteSchedule()
        selectTrainView.initSelectTrain()
        searchScheduleView.initSearchSchedule()
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
    @objc func showAddScheduleView() {
        addScheduleView.addScheduleView.isHidden = false
    }
    //show delete train view
    @objc func showDeleteScheduleView() {
        deleteScheduleView.deleteScheduleView.isHidden = false
    }
    //
    @objc func showSelectTrainView() {
        selectTrainView.selectTrainView.isHidden = false
    }
    
    @objc func showSearchScheduleView() {
        searchScheduleView.searchScheduleView.isHidden = false
    }
    
    @objc func showPreviousView() {
        manageScheduleView.isHidden = true
    }
}
