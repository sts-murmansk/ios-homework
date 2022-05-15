//
//  PostViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post = Post(title: "По умолчанию")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post.title
        view.backgroundColor = .gray
        makeBarItem()
    }
    
    private func makeBarItem() {
        let barItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barItem
    }
                                      
    @objc private func tapAction() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }
}
