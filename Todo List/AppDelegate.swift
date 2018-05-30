//
//  AppDelegate.swift
//  Todo List
//
//  Created by liroy yarimi on 29.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //this is the first function that called when the app upload.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("didFinishLaunchingWithOptions")
        
        //see the address of UserDefaults
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

    //this func called when someting happen to the iphone when the app is running (like user gets phone call)
    func applicationWillResignActive(_ application: UIApplication) {
    }

    //this function called when tha app hide from the screen (like the user pressed the home button)
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("applicationDidEnterBackground")
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // Called when the application is about to terminate.
    func applicationWillTerminate(_ application: UIApplication) {
        
        let message = "applicationWillTerminate"
        print(message)
    }


}

