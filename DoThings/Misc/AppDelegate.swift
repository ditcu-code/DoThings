//
//  AppDelegate.swift
//  SwiftUI Local Notification
//
//  Created by Local Administrator on 07/04/22.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        //TODO: Additional Step 3
        configureUserNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("All set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        return true
    }
}

//TODO: Additional Step 1
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
    private func configureUserNotifications() {
        UNUserNotificationCenter.current().delegate = self
    }
}
