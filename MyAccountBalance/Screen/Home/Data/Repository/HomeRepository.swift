//
//  HomeRepository.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

protocol HomeRepositoryProtocol {
    func fetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void)
    func fetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
    func fetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void)
}

final class HomeRepository {

    // MARK: - Properties
    
     private let homeDataProvider: HomeDataProviderProtocol

    // MARK: - Initialization
    
    init(homeDataProvider: HomeDataProviderProtocol) {
        self.homeDataProvider = homeDataProvider
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func fetchLocalNotificationList(callback: @escaping ([DBMessage]) -> Void) {
        homeDataProvider.fetchLocalNotificationList(callback: callback)
    }
    
    func fetchEmptyNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        homeDataProvider.fetchEmptyNotificationList(completion: completion)
    }
    
    func fetchNotificationList(completion: @escaping (Result<None, NetworkError>) -> Void) {
        homeDataProvider.fetchNotificationList(completion: completion)
    }
}
