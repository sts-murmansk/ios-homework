//
//  InfoViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 10.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2    
        makeButton()
    }
    
    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Закрыть", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
                                      
    @objc private func tapAction() {
        let alert = UIAlertController(title: "Закрыть", message: "Вы хотите закрыть информацию", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
            print("Нажата кнопка Ok")
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { UIAlertAction in
            print("Нажата кнопка Cancel")
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
