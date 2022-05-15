//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = . vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var buttonOne: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Button One", for: .normal)
        $0.backgroundColor = .systemGray
        $0.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var buttonTwo: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Button Two", for: .normal)
        $0.backgroundColor = .systemGray3
        $0.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        view.addSubview(stackView)
        [buttonOne, buttonTwo].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc private func touchAction() {
        let postVC = PostViewController()
        postVC.post = Post(title: "Пост")
        navigationController?.pushViewController(postVC, animated: true)
    }
}
