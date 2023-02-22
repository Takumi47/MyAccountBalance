//
//  HomeViewModel.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import Foundation

struct HomeViewModelNavigation {
    let navigateToNotificationListViewHandler: () -> Void
}

protocol HomeViewModelInput {
    func navigateToNotificationListView()
    func fetchEmptyNotificationList()
    func fetchNotificationList()
}

protocol HomeViewModelOutput {
    var isLoadingObservable: Observable<Bool> { get }
    var notificationListObservable: Observable<[DBMessage]> { get }
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {}

class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    
    private let navigations : HomeViewModelNavigation
    private let useCases: HomeUseCasesProtocol
    
    @Observable private var isLoading: Bool = false
    @Observable private var notificationList: [DBMessage] = []

    // MARK: - Initialization
    
    init (useCases: HomeUseCasesProtocol, navigations: HomeViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }
}

// MARK: - Input protocol implementation

extension HomeViewModel {
    func navigateToNotificationListView() {
        navigations.navigateToNotificationListViewHandler()
    }
    
    func fetchEmptyNotificationList() {
        isLoading = true
        useCases.executeFetchEmptyNotificationList { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_):
                self?.notificationList = []
            case .failure(_):
                break
            }
        }
    }
    
    func fetchNotificationList() {
        isLoading = true
        useCases.executeFetchNotificationList { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_):
                self?.isLoading = true
                self?.useCases.executeFetchLocalNotificationList { list in
                    self?.isLoading = false
                    self?.notificationList = list
                }
            case .failure(_):
                break
            }
        }
    }
}

// MARK: - Output protocol implementation

extension HomeViewModel {
    var isLoadingObservable: Observable<Bool> { $isLoading }
    var notificationListObservable: Observable<[DBMessage]> { $notificationList }
}
