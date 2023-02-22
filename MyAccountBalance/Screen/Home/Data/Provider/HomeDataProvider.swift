//
//  HomeDataProvider.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import CoreData

protocol HomeDataProviderProtocol {
    func fetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void)
    func fetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
    func fetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
}

final class HomeDataProvider {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    
    init(coreDataStack: CoreDataStack = .myAccountBalance, networkManager: NetworkManager = .init()) {
        self.coreDataStack = coreDataStack
        self.networkManager = networkManager
    }
}

extension HomeDataProvider: HomeDataProviderProtocol {
    func fetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void) {
        let request = NSFetchRequest<DBMessage>(entityName: "DBMessage")
        do {
            let results = try CoreDataStack.myAccountBalance.mainContext.fetch(request)
            callback(results)
        } catch  {
            callback([])
        }
    }
    
    func fetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        let service = Service.fetchEmptyNotificationList()
        networkManager.retrieveData(service: service, type: JSONNotificationList.self) { result in
            switch result {
            case .success((let list, _)):
                if list.result.messages.isEmpty {
                    DBMessage.deleteAll()
                }
                completion(.success(None()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        let service = Service.fetchNotificationList()
        networkManager.retrieveData(service: service, type: JSONNotificationList.self) { [weak self] result in
            switch result {
            case .success((let list, _)):
                if DBMessage.currentCount() > 0 {
                    DBMessage.deleteAll()
                    self?.coreDataStack.mainContext.reset()
                }
                
                for message in list.result.messages {
                    let obj = DBMessage(context: CoreDataStack.myAccountBalance.mainContext)
                    obj.status = message.status
                    obj.updateDateTime = message.updateDateTime
                    obj.title = message.title
                    obj.message = message.message
                }
                self?.coreDataStack.saveContext()
                self?.coreDataStack.mainContext.reset()
                completion(.success(None()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
