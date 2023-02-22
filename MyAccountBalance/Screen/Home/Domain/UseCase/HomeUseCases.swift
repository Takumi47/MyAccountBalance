//
//  HomeUseCases.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

protocol HomeUseCasesProtocol {
    func executeFetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void)
    func executeFetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
    func executeFetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
}

final class HomeUseCases {

    // MARK: - Properties
    
     private let repository: HomeRepositoryProtocol

    // MARK: - Initialization
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeUseCases: HomeUseCasesProtocol {
    func executeFetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void) {
        repository.fetchLocalNotificationList(callback: callback)
    }
    
    func executeFetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        repository.fetchEmptyNotificationList(completion: completion)
    }
    
    func executeFetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        repository.fetchNotificationList(completion: completion)
    }
}
