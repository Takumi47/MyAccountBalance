//
//  HomeCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    var homeNavigationController: UINavigationController?
    
    override func start() {
        let navigations = HomeViewModelNavigation()
        homeNavigationController = try? dependencyWrapper.container.resolve(type: UINavigationController.self, argument: navigations, scope: .current)
    }
}
