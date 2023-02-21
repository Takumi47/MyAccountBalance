//
//  LocationDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class LocationDependencyWrapper: BaseDependencyWrapper {
    
    override func registerDependencies() {
        
        // ViewController
        container.register(type: LocationViewController.self, callback: { _ in
            return LocationViewController()
        }, scope: .current)
    }
}
