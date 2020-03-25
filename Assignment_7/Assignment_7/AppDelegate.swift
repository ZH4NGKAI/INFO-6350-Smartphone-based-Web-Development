//
//  AppDelegate.swift
//  Assignment_7
//
//  Created by mac on 3/23/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     func parse(_ string: String, format: String = "yyyy-MM-dd HH:mm") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
    
    var window: UIWindow?
    static var trains = TrainList()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        for i in 1...3 {
            let train = AppDelegate.trains.addTrain(line: "train\(i)", image:UIImage(named: "mbta.png")!)
            train.source = Stop(name: "source\(i)", location: Location(latitude: Double(i), longitude: Double(i)), address: "sourceAddress\(i)")
            train.destination = Stop(name: "destination\(i)", location: Location(latitude: Double(i+10), longitude: Double(i+10)), address: "destinationAddress\(i)")
            if !train.addStop(stop: train.source) {
                return false
            }
            if !train.addStop(stop: train.destination) {
                return false
            }
            for j in 1...3 {
                let schedule = train.addSchedule(arrival:
                    Date(dateString: "2020-\(j)-20 10:30"),
                departure:
                    Date(dateString: "2020-\(j)-21 10:30"))
                if !schedule.addStop(stop: train.source) {
                    return false
                }
                if !schedule.addStop(stop: train.destination) {
                    return false
                }
            }
        }
        return true
    }
}

extension Date {
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
