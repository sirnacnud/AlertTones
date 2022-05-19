//
//  AppDelegate.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 05/19/2022.
//  Copyright (c) 2022 Duncan Cunningham. All rights reserved.
//

import UIKit
import AlertTones

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let alertTonesDataSource = ExampleAlertTonesViewControllerDataSource()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let alertTonesPickerController = AlertTonesPickerController(style: .grouped)
        alertTonesPickerController.dataSource = self.alertTonesDataSource
        alertTonesPickerController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: alertTonesPickerController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

// MARK: - AlertTonesViewControllerDelegate

extension AppDelegate: AlertTonesViewControllerDelegate {
    
    func didSelectAlertTone(alertTone: AlertTone) {
        self.alertTonesDataSource.setSelectedAlertTone(alertTone: alertTone)
    }
}
