//
//  Train.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
import UIKit

class Train {
    var line: String = ""
    var id: Int = 0
    var schedules: Array<Schedule>
    var stops: Array<Stop>
    var source: Stop = Stop()
    var destination: Stop = Stop()
    var image: UIImage = UIImage()
    static var trainId: Int = 1
    
    init(){
        self.schedules = [Schedule]()
        self.stops = [Stop]()
    }
    init(line: String, image: UIImage) {
        self.id = Train.trainId
        Train.trainId += 1
        self.line = line
        self.schedules = [Schedule]()
        self.stops = [Stop]()
        self.image = image
    }
    
    func addSchedule(arrival: Date, departure: Date) -> Schedule{
        let schedule: Schedule = Schedule(arrival: arrival, departure: departure)
        schedules.append(schedule)
        return schedule
    }
    func add_Schedule(arrival: Date, departure: Date){
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
    
    func addStop(name: String, location: Location, address: String) -> Stop?{
        for stop in stops {
            if stop.name == name {
                return nil
            }
        }
        let stop: Stop = Stop(name: name, location: location, address: address);
        stops.append(stop)
        return stop;
    }
    
    func addStop(stop: Stop) -> Bool {
        for estop in stops {
            if estop.name == stop.name {
                return false
            }
        }
        stops.append(stop)
        return true
    }
    
    func deleteStop(name: String) -> Bool{
        for i in 0...stops.count-1{
            if stops[i].name == name {
                stops.remove(at: i)
                return true
            }
        }
        return false
    }
    
    func searchStop(name: String) -> Stop? {
        for stop in stops {
            if stop.name == name {
                return stop
            }
        }
        return nil
    }
}
