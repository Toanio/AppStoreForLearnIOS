//
//  BaseTapBarController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 16.11.2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: TodayController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
        ]
       
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        //TODO: разобраться почему так работает?
//        viewController.view.backgroundColor = .white
//        viewController.navigationItem.title = title
//
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = UIImage(named: imageName)
//        navController.navigationBar.prefersLargeTitles = true
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
        
    }
}
