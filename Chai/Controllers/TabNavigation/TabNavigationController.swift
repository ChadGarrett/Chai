//
//  TabNavigationController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/03.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

final class TabNavigationController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.configureTabs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates the tabs that are available and adds them as tab controllers
    private func configureTabs() {
        let home = self.configureHomeNavigationController()
        let shopping = self.configureShoppingNavigationController()
        
        self.viewControllers = [home, shopping]
    }
    
    @discardableResult
    private func configureHomeNavigationController() -> UIViewController {
        let navigationController = UINavigationController()
        let controller = HomeViewController()
        
        navigationController.viewControllers = [controller]
        navigationController.tabBarItem = UITabBarItem(title: "Home Controller", image: nil, selectedImage: nil)
        
        return navigationController
    }
    
    @discardableResult
    private func configureShoppingNavigationController() -> UIViewController {
        let navigationController = UINavigationController()
        let controller = ShoppingListController()
        navigationController.viewControllers = [controller]
        navigationController.tabBarItem = UITabBarItem(title: "Shopping", image: nil, selectedImage: nil)
        
        return navigationController
    }
    
    @discardableResult
    private func configureSettingsNavigationController() -> UIViewController {
        // TODO
        return UIViewController()
    }
}

extension TabNavigationController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
