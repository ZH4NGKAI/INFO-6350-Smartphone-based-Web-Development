//
//  Schedule.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation

class Schedule {
    var arrival: DateComponents?
    var departure: DateComponents?
    var id: Int = 0
    var stops: Array<Stop>
    static var scheduleId: Int = 1
        
    init(arrival: DateComponents, departure: DateComponents) {
        self.id = Schedule.scheduleId
        Schedule.scheduleId += 1
        self.arrival = arrival
        self.departure = departure
        stops = [Stop]()
    }
    
    func addStop(name:String, location: Location, address: String) -> Bool{
        for stop in stops {
            if stop.name == name {
                return false
            }
        }
        let stop = Stop(name: name, location: location, address: address)
        stops.append(stop)
        return true
    }
    
    func deleteStop(name: String) -> Bool {
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
