//
//  Train.swift
//  EmptyApp
//
//  Created by mac on 2/29/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation

enum LineName{
    case Red
    case Silver
    case Orange
}

class Train {
    var line: String = ""
    var id: Int = 0
    var schedules: Array<Schedule>
    static var trainId: Int = 1
        
    init(line: String) {
        self.id = Train.trainId
        Train.trainId += 1
        self.line = line
        self.schedules = [Schedule]()
    }
    
    static func deleteTrain(id: Int) -> Bool{
        for i in 0...AppDelegate.TrainDirectory.count-1{
            if AppDelegate.TrainDirectory[i].id == id {
                AppDelegate.TrainDirectory.remove(at: i)
                return true
            }
        }
        return false
    }
    
    static func searchTrain(id: Int) -> Train? {
        for train in AppDelegate.TrainDirectory {
            if train.id == id {
                return train
            }
        }
        return nil
    }
}
