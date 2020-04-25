//
//  AppDelegate.swift
//  Messenger
//
//  Created by mac on 4/22/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CometChatPro

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // init
        self.initialization()
        
        //register to receive real time call events
        
        if CometChat.getLoggedInUser() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "barController") as! BarController
            let navigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
           self.window?.rootViewController = navigationController
           self.window?.makeKeyAndVisible()
        }
        return true
    }

    func initialization(){
        if(Constants.appId.contains(NSLocalizedString("Enter", comment: "")) || Constants.appId.contains(NSLocalizedString("ENTER", comment: "")) || Constants.appId.contains("NULL") || Constants.appId.contains("null") || Constants.appId.count == 0){

        }else{
            let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: Constants.region).build()
            CometChat.init(appId:Constants.appId, appSettings: appSettings, onSuccess: { (Success) in
                print( "Initialization onSuccess \(Success)")
            }) { (error) in
                print( "Initialization Error \(error.errorDescription)")
            }
        }
    }
    
}

