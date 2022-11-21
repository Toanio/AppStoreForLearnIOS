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
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
        ]
       
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
        
    }
}
