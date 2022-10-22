//
//  AppDelegate.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 25.05.2022.
//

import SwiftUI
import GoogleMobileAds

// MARK: - UIApplicationDelegate

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
