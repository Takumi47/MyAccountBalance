//
//  XError.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

struct XError: Error {
    var code: Int
    var title: String
    var message: String = ""
}

extension XError {
    static func noComponentFoundInContainer(type: String) -> XError {
        XError(code: 9999, title: "The component \(type) doesn't exist")
    }
    
    static let dependencyResolverArgumentsMismatch = XError(code: 9999, title: "Arguments mismatch for dependency resolver")
    static let dependencyResolverInternalError = XError(code: 9999, title: "Dependency injection internal error")
}
