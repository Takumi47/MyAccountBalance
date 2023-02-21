//
//  BaseDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

protocol BaseDependencyWrapperProtocol {
    var container: DIContainerProtocol { get }
    func registerDependencies()
}

class BaseDependencyWrapper: BaseDependencyWrapperProtocol {
    var container: DIContainerProtocol
    
    init(key: String) {
        self.container = DIContainer(key: key)
    }
    
    func registerDependencies() {
    }
}

