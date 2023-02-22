//
//  HomeModels.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import Foundation

// MARK: - Models

struct None: Decodable {}

struct JSONNotificationList: Decodable {
    var result: JSONMessages
    
    enum CodingKeys: String, CodingKey {
        case result
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(JSONMessages.self, forKey: .result)
    }
}

struct JSONMessages: Decodable {
    var messages: [JSONMessage]
    
    enum CodingKeys: String, CodingKey {
        case messages
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        messages = try container.decodeIfPresent([JSONMessage].self, forKey: .messages) ?? []
    }
}

struct JSONMessage: Decodable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}
