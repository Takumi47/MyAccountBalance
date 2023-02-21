//
//  HomeUseCases.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

protocol HomeUseCasesProtocol {
}

final class HomeUseCases {

    // MARK: - Public variables

    // MARK: - Private variables
    
     private let repository: HomeRepositoryProtocol

    // MARK: - Initialization
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeUseCases: HomeUseCasesProtocol {
}
