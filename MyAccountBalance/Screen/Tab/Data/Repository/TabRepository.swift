//
//  TabRepository.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

protocol TabRepositoryProtocol {
}

final class TabRepository {

    // MARK: - Public variables

    // MARK: - Private variables
    // private let dataProvider: ADataProviderProtocol!

    // MARK: - Initialization
    
    init() {
      //TODO: inject data providers dependecies here
    }
}

extension TabRepository: TabRepositoryProtocol {
}
