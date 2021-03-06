//
//  AppDelegate.swift
//  Queue
//
//  Created by Taylor Mott on 3/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = UIColor(red: 0.204, green: 0.675, blue: 0.878, alpha: 1.00)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, .Alert, .Badge], categories: nil))
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        guard let remoteNotificationDictionary = userInfo as? [String : NSObject] else { return }
        let cloudKitNotification = CKQueryNotification(fromRemoteNotificationDictionary: remoteNotificationDictionary)
        guard let notificationInfo = cloudKitNotification.recordFields as? [String : String] else { return }
        
        var alertBody = ""
        
        let studentName = notificationInfo["studentName"] ?? "(No Name)"
        alertBody = alertBody + studentName + " asked: "
        let question = notificationInfo["body"] ?? "(No Question)"
        alertBody = alertBody + question
        
        let localNotification = UILocalNotification()
        localNotification.alertBody = alertBody
        localNotification.alertTitle = "New Queue Question"
        
        application.presentLocalNotificationNow(localNotification)
        
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        let alert = UIAlertController(title: notification.alertTitle, message: notification.alertBody, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        
        window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

