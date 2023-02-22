//
//  DBMessage+CoreDataClass.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//
//

import Foundation
import CoreData

@objc(DBMessage)
public class DBMessage: NSManagedObject {
    
    public class func currentCount() -> Int {
        let fetchRequest: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        return (try? CoreDataStack.myAccountBalance.mainContext.count(for: fetchRequest)) ?? 0
    }
    
    public class func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: DBMessage.fetchRequest())
        deleteRequest.resultType = .resultTypeCount
        
        do {
            let resultBox = try CoreDataStack.myAccountBalance.mainContext.execute(deleteRequest) as? NSBatchDeleteResult
            let _ = resultBox?.result as? Int ?? 0
        } catch {
        }
        
        CoreDataStack.myAccountBalance.saveContext()
    }
}
