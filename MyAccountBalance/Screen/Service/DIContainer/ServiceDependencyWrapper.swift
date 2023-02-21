//
//  ServiceDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class ServiceDependencyWrapper: BaseDependencyWrapper {
    
    override func registerDependencies() {
        
        // ViewController
        container.register(type: ServiceViewController.self, callback: { _ in
            return ServiceViewController()
        }, scope: .current)
    }
}
