//
//  AppDelegate.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
