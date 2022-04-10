//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let feedVC = FeedViewController()
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContollers()
    }
    
    private func setupContollers() {
        feedVC.title = "Лента"
        let feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.tabBarItem.title = "Лента"
        feedNC.tabBarItem.image = UIImage(systemName: "newspaper")
        
        profileVC.title = "Профиль"
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.tabBarItem.title = "Профиль"
        profileNC.tabBarItem.image = UIImage(systemName: "person")
        
        viewControllers = [feedNC, profileNC]
    }
}
