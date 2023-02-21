//
//  TabBarCoordinator.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    var window: UIWindow?
    private var tabBarController: UITabBarController?
    private var homeCoordinator: HomeCoordinator?
    private var accountCoordinator: AccountCoordinator?
    private var locationCoordinator: LocationCoordinator?
    private var serviceCoordinator: ServiceCoordinator?
    
    override func start() {
        tabBarController = try? dependencyWrapper.container.resolve(type: UITabBarController.self, scope: .current)
        
        var viewControllers: [UIViewController] = []
        
        if let homeViewController = addHomeView() {
            viewControllers.append(homeViewController)
        }
        
        if let accountViewController = addAccountView() {
            viewControllers.append(accountViewController)
        }
        
        if let locationViewController = addLocationView() {
            viewControllers.append(locationViewController)
        }
        
        if let serviceViewController = addServiceView() {
            viewControllers.append(serviceViewController)
        }
        
        tabBarController?.viewControllers = viewControllers
        tabBarController?.tabBar.tintColor = .orange01
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func addHomeView() -> UINavigationController? {
        let homeDependencyWrapper: BaseDependencyWrapper = HomeDependencyWrapper(key: "Home")
        homeDependencyWrapper.registerDependencies()
        homeCoordinator = HomeCoordinator(dependencyWrapper: homeDependencyWrapper)
        homeCoordinator?.start()
        let vc = homeCoordinator?.homeNavigationController
        vc?.tabBarItem.title = "Home"
        vc?.tabBarItem.image = UIImage(named: "home")
        return vc
    }
    
    private func addAccountView() -> AccountViewController? {
        let accountDependencyWrapper: BaseDependencyWrapper = AccountDependencyWrapper(key: "Account")
        accountDependencyWrapper.registerDependencies()
        accountCoordinator = AccountCoordinator(dependencyWrapper: accountDependencyWrapper)
        accountCoordinator?.start()
        let vc = accountCoordinator?.accountViewController
        vc?.tabBarItem.title = "Account"
        vc?.tabBarItem.image = UIImage(named: "account")
        vc?.tabBarItem.isEnabled = false
        return vc
    }
    
    private func addLocationView() -> LocationViewController? {
        let locationDependencyWrapper: BaseDependencyWrapper = LocationDependencyWrapper(key: "Location")
        locationDependencyWrapper.registerDependencies()
        locationCoordinator = LocationCoordinator(dependencyWrapper: locationDependencyWrapper)
        locationCoordinator?.start()
        let vc = locationCoordinator?.locationViewController
        vc?.tabBarItem.title = "Location"
        vc?.tabBarItem.image = UIImage(named: "location")
        vc?.tabBarItem.isEnabled = false
        return vc
    }
    
    private func addServiceView() -> ServiceViewController? {
        let serviceDependencyWrapper: BaseDependencyWrapper = ServiceDependencyWrapper(key: "Service")
        serviceDependencyWrapper.registerDependencies()
        serviceCoordinator = ServiceCoordinator(dependencyWrapper: serviceDependencyWrapper)
        serviceCoordinator?.start()
        let vc = serviceCoordinator?.serviceViewController
        vc?.tabBarItem.title = "Service"
        vc?.tabBarItem.image = UIImage(named: "service")
        vc?.tabBarItem.isEnabled = false
        return vc
    }
}
