//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeButton()
    }
    
    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Пост", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
                                      
    @objc private func tapAction() {
        let postVC = PostViewController()
        postVC.post = Post(title: "Пост")
        navigationController?.pushViewController(postVC, animated: true)
    }
}
