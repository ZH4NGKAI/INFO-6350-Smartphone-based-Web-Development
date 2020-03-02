//
//  Schedule.swift
//  EmptyApp
//
//  Created by mac on 2/29/20.
//  Copyright © 2020 rab. All rights reserved.
//

import Foundation

class Schedule {
    var arrival: DateComponents?
    var departure: DateComponents?
    var id: Int = 0
    static var scheduleId: Int = 1
        
    init(arrival: DateComponents, departure: DateComponents) {
        self.id = Schedule.scheduleId
        Schedule.scheduleId += 1
        self.arrival = arrival
        self.departure = departure
    }
    
    static func deleteSchedule(id: Int) -> Bool {
        for train in AppDelegate.TrainDirectory{
            for i in 0...train.schedules.count-1{
                if train.schedules[i].id == id {
                    train.schedules.remove(at: i)
                    return true
                }
            }
        }
        return false
    }
}
