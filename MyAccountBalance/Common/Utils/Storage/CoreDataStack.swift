//
//  CoreDataStack.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import CoreData

class CoreDataStack {
    
    // MARK: - Properties
    
    private let modelName: String
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error as NSError? {
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        self.storeContainer.viewContext
    }()
    
    static var myAccountBalance: CoreDataStack = {
        CoreDataStack(modelName: "MyAccountBalance")
    }()
    
    // MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
}

// MARK: - Methods

extension CoreDataStack {
    
    func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let err as NSError {
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
    }
}
