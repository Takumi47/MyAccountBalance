//
//  DBMessage+CoreDataProperties.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//
//

import Foundation
import CoreData


extension DBMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMessage> {
        return NSFetchRequest<DBMessage>(entityName: "DBMessage")
    }

    @NSManaged public var status: Bool
    @NSManaged public var updateDateTime: String
    @NSManaged public var title: String
    @NSManaged public var message: String

}

extension DBMessage : Identifiable {
}
