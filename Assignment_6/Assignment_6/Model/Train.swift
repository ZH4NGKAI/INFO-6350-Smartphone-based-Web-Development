//
//  Train.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation

class Train {
    var line: String = ""
    var id: Int = 0
    var schedules: Array<Schedule>
    var source: Stop?
    var destination: Stop?
    static var trainId: Int = 1
    
    init(line: String) {
        self.id = Train.trainId
        Train.trainId += 1
        self.line = line
        self.schedules = [Schedule]()
    }
    
    func addSchedule(arrival: DateComponents, departure: DateComponents) -> Schedule{
        let schedule: Schedule = Schedule(arrival: arrival, departure: departure)
        schedules.append(schedule)
        return schedule
    }
    func add_Schedule(arrival: DateComponents, departure: DateComponents){
        let schedule: Schedule = Schedule(arrival: arrival, departure: departure)
        schedules.append(schedule)
    }
    
    func deleteSchedule(id: Int) -> Bool{
        for i in 0...schedules.count-1{
            if schedules[i].id == id {
                schedules.remove(at: i)
                return true
            }
        }
        return false
    }
    
    func searchSchedule(id: Int) -> Schedule? {
        for schedule in schedules {
            if schedule.id == id {
                return schedule
            }
        }
        return nil
    }
}
