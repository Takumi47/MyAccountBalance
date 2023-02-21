//
//  AccountCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class AccountCoordinator: BaseCoordinator {
    
    var accountViewController: AccountViewController?
    
    override func start() {
        accountViewController = try? dependencyWrapper.container.resolve(type: AccountViewController.self, scope: .current)
    }
}
