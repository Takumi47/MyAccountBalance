//
//  HomeRepository.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

protocol HomeRepositoryProtocol {
}

final class HomeRepository {

    // MARK: - Public variables

    // MARK: - Private variables
    
     private let homeDataProvider: HomeDataProviderProtocol

    // MARK: - Initialization
    
    init(homeDataProvider: HomeDataProviderProtocol) {
        self.homeDataProvider = homeDataProvider
    }
}

extension HomeRepository: HomeRepositoryProtocol {
}
