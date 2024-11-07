//
//  AppDelegate.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = CryptoListViewController()        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
