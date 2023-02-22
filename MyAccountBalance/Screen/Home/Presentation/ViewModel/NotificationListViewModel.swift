//
//  NotificationListViewModel.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import Foundation

struct NotificationListViewModelNavigation {
    let navigateBackHandler: () -> Void
}

protocol NotificationListViewModelInput {
    func navigateBack()
    func fetchLocalNotificationList()
}

protocol NotificationListViewModelOutput {
    var notificationListObservable: Observable<[DBMessage]> { get }
}

protocol NotificationListViewModelProtocol: NotificationListViewModelInput, NotificationListViewModelOutput {}

class NotificationListViewModel: NotificationListViewModelProtocol {

    // MARK: - Properties
    
    private let navigations : NotificationListViewModelNavigation
    private let useCases: HomeUseCasesProtocol
    
    @Observable private var notificationList: [DBMessage] = []
    
    // MARK: - Initialization
    
    init (useCases: HomeUseCasesProtocol, navigations: NotificationListViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }
}

// MARK: - Input protocol implementation

extension NotificationListViewModel {
    func navigateBack() {
        navigations.navigateBackHandler()
    }
    
    func fetchLocalNotificationList() {
        useCases.executeFetchLocalNotificationList { [weak self] list in
            self?.notificationList = list
        }
    }
}

// MARK: - Output protocol implementation

extension NotificationListViewModel {
    var notificationListObservable: Observable<[DBMessage]> { $notificationList }
}
