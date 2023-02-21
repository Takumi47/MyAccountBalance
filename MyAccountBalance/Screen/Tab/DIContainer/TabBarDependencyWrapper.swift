//
//  TabBarDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class TabBarDependencyWrapper: BaseDependencyWrapper {
    
    override func registerDependencies() {
        
        // ViewController
        container.register(type: UITabBarController.self, callback: { _ in
            return UITabBarController()
        }, scope: .current)
    }
}
