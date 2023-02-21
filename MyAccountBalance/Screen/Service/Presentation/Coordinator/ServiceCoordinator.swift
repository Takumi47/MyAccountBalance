//
//  ServiceCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class ServiceCoordinator: BaseCoordinator {
    
    var serviceViewController: ServiceViewController?
    
    override func start() {
        serviceViewController = try? dependencyWrapper.container.resolve(type: ServiceViewController.self, scope: .current)
    }
}
