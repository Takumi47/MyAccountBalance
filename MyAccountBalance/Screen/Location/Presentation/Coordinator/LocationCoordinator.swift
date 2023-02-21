//
//  LocationCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class LocationCoordinator: BaseCoordinator {
    
    var locationViewController: LocationViewController?
    
    override func start() {
        locationViewController = try? dependencyWrapper.container.resolve(type: LocationViewController.self, scope: .current)
    }
}
