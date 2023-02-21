//
//  HomeViewModel.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import Foundation

struct HomeViewModelNavigation {
    // let navigateToOtherView: () -> ()
}

protocol HomeViewModelInput {
    // func viewDidLoad()
}

protocol HomeViewModelOutput {
    // @Observable var dataObservable: DataType  { get }
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {}

class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Public variables

    // MARK: - Private variables
    
    private let navigations : HomeViewModelNavigation
    private let useCases: HomeUseCasesProtocol

    // MARK: - Initialization
    
    init (useCases: HomeUseCasesProtocol, navigations: HomeViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }
}

// MARK: - Input protocol implementation

extension HomeViewModel {
}

// MARK: - Output protocol implementation

extension HomeViewModel {
}
