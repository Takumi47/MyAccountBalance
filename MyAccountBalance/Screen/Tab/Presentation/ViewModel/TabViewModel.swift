//
//  TabViewModel.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import Foundation

struct TabViewModelNavigation {
    // let navigateToOtherView: () -> ()
}

protocol TabViewModelInput {
    // func viewDidLoad()
}

protocol TabViewModelOutput {
    // @Observable var dataObservable: DataType  { get }
}

protocol TabViewModelProtocol: TabViewModelInput, TabViewModelOutput {}

class TabViewModel: TabViewModelProtocol {

    // MARK: - Public variables

    // MARK: - Private variables
    
    private let navigations : TabViewModelNavigation
    private let useCases: TabUseCasesProtocol

    // MARK: - Initialization
    
    init (useCases: TabUseCasesProtocol, navigations: TabViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }
}

// MARK: - Input protocol implementation

extension TabViewModel {
}

// MARK: - Output protocol implementation

extension TabViewModel {
}
