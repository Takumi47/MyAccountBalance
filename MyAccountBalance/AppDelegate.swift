//
//  AppDelegate.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarCoordinator: TabBarCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let dependencyWrapper: BaseDependencyWrapper = TabBarDependencyWrapper(key: "TabBar")
        dependencyWrapper.registerDependencies()
        tabBarCoordinator = TabBarCoordinator(dependencyWrapper: dependencyWrapper)
        tabBarCoordinator?.window = window
        tabBarCoordinator?.start()
        return true
    }
}

