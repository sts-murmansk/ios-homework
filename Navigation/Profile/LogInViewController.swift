//
//  LogInViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 26.04.2022.
//

import UIKit
import SwiftUI

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default

    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        return $0
    }(UIImageView())
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = . vertical
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor =  UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 10.0
        return $0
    }(UIStackView())
    
    private lazy var userTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.autocapitalizationType = .none
        $0.placeholder = "Email или Телефон"
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor =  UIColor.lightGray.cgColor
        $0.delegate = self
        // добавим отступ слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = UITextField.ViewMode.always
        return $0
    }(UITextField())
    
    private lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.tintColor = UITextField.appearance().tintColor
        $0.autocapitalizationType = .none
        $0.placeholder = "Пароль"
        $0.delegate = self
        $0.isSecureTextEntry = true
        // добавим отступ слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = UITextField.ViewMode.always
        return $0
    }(UITextField())
    
    private lazy var loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Войти", for: .normal)
        $0.clipsToBounds = true
        let bgImage = UIImage(named: "blue_pixel")!
        $0.setBackgroundImage(bgImage.image(alpha: 1.0), for: .normal)
        $0.setBackgroundImage(bgImage.image(alpha: 0.8), for: .selected)
        $0.setBackgroundImage(bgImage.image(alpha: 0.8), for: .highlighted)
        $0.setBackgroundImage(bgImage.image(alpha: 0.8), for: .disabled)
        $0.tintColor = .white
        $0.layer.cornerRadius = 10.0
        $0.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func layout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            /// Обязательно выставить ширину contentView !!!!
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [logoImageView, stackView, loginButton].forEach { contentView.addSubview($0) }
        
        let margin = 16.0
        
        
        NSLayoutConstraint.activate([
            // logoImageView
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 100.0),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100.0),
            // stackView
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100.0),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            // loginButton
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: margin),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            /// Обязательно закрепиться к низу  contentView !!!!
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
        
        [userTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }
    }
    
    @objc private func touchAction() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - UIImage

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
