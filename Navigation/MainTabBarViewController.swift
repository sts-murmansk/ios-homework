//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private let feedVC: FeedViewController = {
        $0.title = "Лента"
        return $0
    }(FeedViewController())
    
    private let loginVC: LogInViewController = {
        $0.title = "Профиль"
        return $0
    }(LogInViewController())
    
    private lazy var feedNC: UINavigationController = {
        $0.tabBarItem.title = "Лента"
        $0.tabBarItem.image = UIImage(systemName: "newspaper")
        return $0
    }(UINavigationController(rootViewController: feedVC))

    private lazy var loginNC: UINavigationController = {
        $0.tabBarItem.title = "Профиль"
        $0.tabBarItem.image = UIImage(systemName: "person")
        $0.navigationBar.isHidden = true
        return $0
    }(UINavigationController(rootViewController: loginVC))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        viewControllers = [feedNC, loginNC]
    }
}
