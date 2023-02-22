//
//  HomeCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    var homeNavigationController: UINavigationController?
    
    override func start() {
        let navigations = HomeViewModelNavigation { [weak self] in
            self?.navigateToNotificationListView()
        }
        homeNavigationController = try? dependencyWrapper.container.resolve(type: UINavigationController.self, argument: navigations, scope: .current)
    }
}

// MARK: - Navigation

extension HomeCoordinator {
    private func navigateToNotificationListView() {
        guard let dependencyWrapper = dependencyWrapper as? HomeDependencyWrapper else { return }
        dependencyWrapper.registerNotificationListDependencies()
        
        let navigations = NotificationListViewModelNavigation { [weak self] in
            self?.navigateBack()
        }
        let viewController = try? dependencyWrapper.container.resolve(type: NotificationListViewController.self, argument: navigations, scope: .current)
        guard let navController = homeNavigationController, let vc = viewController else { return }
        navController.pushViewController(vc, animated: true)
        navController.tabBarController?.tabBar.isHidden = true
    }
    
    private func navigateBack() {
        guard let navController = homeNavigationController else { return }
        navController.popViewController(animated: true)
        navController.tabBarController?.tabBar.isHidden = false
    }
}
