//
//  Service.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

struct Service: RequestDefinition {
    var baseURL: String = "https://willywu0201.github.io/data"
    var path: String
    var method: NetworkClient.Method
    var headers: [String: String]?
    var query: [String: String]?
    var body: Data?
    var returnType: Decodable.Type
}

// MARK: - Notification List

extension Service {
    static func fetchEmptyNotificationList() -> Service {
        Service(path: "emptyNotificationList.json", method: .get, returnType: JSONNotificationList.self)
    }
    
    static func fetchNotificationList() -> Service {
        Service(path: "notificationList.json", method: .get, returnType: JSONNotificationList.self)
    }
}
