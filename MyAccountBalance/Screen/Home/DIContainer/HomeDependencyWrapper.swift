//
//  HomeDependencyWrapper.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class HomeDependencyWrapper: BaseDependencyWrapper {
    
    override func registerDependencies() {
        
        // DataProvider
        container.register(type: HomeDataProviderProtocol.self, callback: { _ in
            return HomeDataProvider()
        }, scope: .current)
        
        // Repository
        container.register(type: HomeRepositoryProtocol.self, callback: { resolver in
            let dataProvider = try resolver.resolve(type: HomeDataProviderProtocol.self, scope: .current)
            return HomeRepository(homeDataProvider: dataProvider)
        }, scope: .current)
        
        // UseCases
        container.register(type: HomeUseCasesProtocol.self, callback: { resolver in
            let repository = try resolver.resolve(type: HomeRepositoryProtocol.self, scope: .current)
            return HomeUseCases(repository: repository)
        }, scope: .current)
        
        // ViewModel
        container.register(type: HomeViewModelProtocol.self, callback: { (resolver, navigations: HomeViewModelNavigation) in
            let useCases = try resolver.resolve(type: HomeUseCasesProtocol.self, scope: .current)
            return HomeViewModel(useCases: useCases, navigations: navigations)
        }, scope: .current)
        
        // ViewController
        container.register(type: HomeViewController.self, callback: { (resolver, navigations: HomeViewModelNavigation) in
            let viewModel = try resolver.resolve(type: HomeViewModelProtocol.self, argument: navigations, scope: .current)
            return HomeViewController(viewModel: viewModel)
        }, scope: .current)
        
        container.register(type: UINavigationController.self, callback: { (resolver, navigations: HomeViewModelNavigation) in
            let viewController = try resolver.resolve(type: HomeViewController.self, argument: navigations, scope: .current)
            return UINavigationController(rootViewController: viewController)
        }, scope: .current)
    }
    
    func registerNotificationListDependencies() {
        
        // ViewModel
        container.register(type: NotificationListViewModelProtocol.self, callback: { (resolver, navigations: NotificationListViewModelNavigation) in
            let useCases = try resolver.resolve(type: HomeUseCasesProtocol.self, scope: .current)
            return NotificationListViewModel(useCases: useCases, navigations: navigations)
        }, scope: .current)
        
        // ViewController
        container.register(type: NotificationListViewController.self, callback: { (resolver, navigations: NotificationListViewModelNavigation) in
            let viewModel = try resolver.resolve(type: NotificationListViewModelProtocol.self, argument: navigations, scope: .current)
            return NotificationListViewController(viewModel: viewModel)
        }, scope: .current)
    }
}
