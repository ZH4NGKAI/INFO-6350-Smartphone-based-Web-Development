//
//  AppDelegate.swift
//  EmptyApp
//
//  Created by rab on 02/15/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var homeView = UIView()
    var customerManageView: UIView?
    let homePage = WelcomeView()
    static var homeViewRect = CGRect()
    static var TrainDirectory: Array<Train> = Array()
    var calendar = Calendar(identifier:Calendar.Identifier.iso8601)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.lightGray
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        //home page
        AppDelegate.homeViewRect = CGRect(x:0,y:0,width:screenWidth, height:screenHeight); //XR:1792 * 828
        AppDelegate.homeView = UIView(frame:AppDelegate.homeViewRect)
        AppDelegate.homeView.backgroundColor = UIColor.white
        window!.addSubview(AppDelegate.homeView);
        
        initSystem()
        homePage.initWelcome()
        return true
    }
    
    func initSystem(){
        let t1 = Train(line: "Orange")
        let t2 = Train(line: "Red")
        let t3 = Train(line: "Silver")
        AppDelegate.TrainDirectory.append(t1)
        AppDelegate.TrainDirectory.append(t2)
        AppDelegate.TrainDirectory.append(t3)
        
        let s1 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:14, minute: 30))
        
        let s2 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:14, minute: 30))
        
        let s3 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:15, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:19, minute: 30))
        
        let s4 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:14, minute: 30))
        
        let s5 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:14, minute: 30))
        
        let s6 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:15, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:19, minute: 30))
        
        let s7 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 2,day: 29, hour:14, minute: 30))
        
        let s8 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:10, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:14, minute: 30))
        
        let s9 = Schedule(
        arrival:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:15, minute: 30),
        departure:
        DateComponents(calendar: calendar,year: 2020,month: 3,day: 1, hour:19, minute: 30))
        
        t1.schedules.append(s1)
        t1.schedules.append(s2)
        t1.schedules.append(s3)
        t2.schedules.append(s4)
        t2.schedules.append(s5)
        t2.schedules.append(s6)
        t3.schedules.append(s7)
        t3.schedules.append(s8)
        t3.schedules.append(s9)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

