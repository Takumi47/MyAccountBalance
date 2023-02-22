//
//  NetworkError.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

enum NetworkError: Error {
    case noNetwork
    case invalidURL
    case defaultError(code: Int = 9999, desc: String = "")
    
    var code: Int {
        switch self {
        case .defaultError(let code, _):
            return code
        default:
            return 9999
        }
    }
    
    var description: String {
        switch self {
        case .noNetwork:
            return NSLocalizedString("No Network Connection", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .defaultError(_, let desc):
            return NSLocalizedString(desc, comment: "")
        }
    }
}
