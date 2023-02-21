//
//  AccountDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class AccountDependencyWrapper: BaseDependencyWrapper {
    
    override func registerDependencies() {
        
        // ViewController
        container.register(type: AccountViewController.self, callback: { _ in
            return AccountViewController()
        }, scope: .current)
    }
}
