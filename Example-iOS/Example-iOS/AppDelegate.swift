//
//  AppDelegate.swift
//  Example-iOS
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.black
        let rootVC = ViewController()
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

