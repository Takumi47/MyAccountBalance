//
//  BaseCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import UIKit

class BaseCoordinator {
    
    // MARK: - Properties
    
    var dependencyWrapper: BaseDependencyWrapperProtocol
    var navController: UINavigationController?
    weak var parentController: UIViewController?
    
    // MARK: - Initialization
    
    init(dependencyWrapper: BaseDependencyWrapperProtocol, navController: UINavigationController? = nil, parentController: UIViewController? = nil) {
        self.dependencyWrapper = dependencyWrapper
        self.navController = navController
        self.parentController = parentController
    }
    
    // MARK: - Methods
    
    func start() {
    }
}
