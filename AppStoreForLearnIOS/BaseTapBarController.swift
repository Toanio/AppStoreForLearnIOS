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
        let todayController = UIViewController()
        todayController.view.backgroundColor = .white
        todayController.navigationItem.title = "Today"
       
        let todayNavController = UINavigationController(rootViewController: todayController)
        todayNavController.tabBarItem.title = "Today"
        todayNavController.tabBarItem.image = UIImage(named: "today_icon")
        todayNavController.navigationBar.prefersLargeTitles = true
        
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .white
        redViewController.navigationItem.title = "Apps"
       
        let redNavController = UINavigationController(rootViewController: redViewController)
        redNavController.tabBarItem.title = "Apps"
        redNavController.tabBarItem.image = UIImage(named: "apps")
        redNavController.navigationBar.prefersLargeTitles = true
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .white
        blueViewController.navigationItem.title = "Search"
        
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        blueNavController.tabBarItem.title = "Search"
        blueNavController.tabBarItem.image = UIImage(named: "search")
        blueNavController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            todayNavController,
            redNavController,
            blueNavController,
        ]
    }
}
