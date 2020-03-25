//
//  AppDelegate.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var trains = TrainList()
    var calendar = Calendar(identifier:Calendar.Identifier.iso8601)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        for i in 1...3 {
            let train = AppDelegate.trains.addTrain(line: "train\(i)")
            train.source = Stop(name: "source\(i)", location: Location(latitude: Double(i), longitude: Double(i)), address: "sourceAddress\(i)")
            train.destination = Stop(name: "destination\(i)", location: Location(latitude: Double(i+10), longitude: Double(i+10)), address: "destinationAddress\(i)")
            for j in 1...3 {
                let schedule = train.addSchedule(arrival:
                DateComponents(calendar: calendar,year: 2020,month: j,day: 20, hour:10, minute: 30),
                departure:
                DateComponents(calendar: calendar,year: 2020,month: j,day: 20, hour:14, minute: 30))
                for k in 1...3 {
                    if (schedule.addStop(name: "stop\(k)", location: Location(latitude: Double(k), longitude: Double(k)), address: "address\(k)")) {
                        continue
                    }
                }
            }
        }
        return true
    }
}

