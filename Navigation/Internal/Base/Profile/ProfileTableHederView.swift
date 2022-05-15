//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Цветков on 12.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let captionFontSize = 18.0
    private let titleFontSize = 14.0
    private let textFieldFontSize = 15.0
    private let margin = 16.0
    private let avatarSize = 100.0
    
    private let blackView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    private let closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "xmark.square"), for: .normal)
        $0.alpha = 0.0
        return $0
    }(UIButton())
    
    private lazy var avatarImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "Cat")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.layer.borderWidth = 3.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = avatarSize / 2.0
        return $0
    }(UIImageView())
 
    private lazy var captionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Porsche Cat"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: captionFontSize, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Waiting for something..."
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: captionFontSize, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Show status", for: .normal)
        $0.backgroundColor = .init(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        $0.layer.shadowRadius = 4.0
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        $0.layer.cornerRadius = 4.0
        $0.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .regular)
        $0.textColor = .black
        $0.placeholder = "Введите статус"
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 12.0
        $0.addTarget(self, action: #selector(editAction), for: .editingChanged)
        // добавим отступ слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = UITextField.ViewMode.always
        return $0
    }(UITextField())
    
    private var statusText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        
        layout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented");
    }
    
    private func layout() {
        [captionLabel, titleLabel, button, textField, blackView, avatarImage].forEach { addSubview($0) }
        blackView.addSubview(closeButton)
      
        NSLayoutConstraint.activate([
            // avatar constraint
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            avatarImage.heightAnchor.constraint(equalToConstant: avatarSize),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarSize),
            // blackView
            blackView.topAnchor.constraint(equalTo: topAnchor),
            blackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            blackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            // closeButton
            closeButton.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 10.0),
            closeButton.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 40.0),
            closeButton.heightAnchor.constraint(equalToConstant: 40.0),
            // captionLabel constraint
            captionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            captionLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: margin),
            captionLabel.heightAnchor.constraint(equalToConstant: captionLabel.font.lineHeight),
            captionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            // titleLabel constraint
            titleLabel.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -34.0),
            titleLabel.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.font.lineHeight),
            titleLabel.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            // textField constraint
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            textField.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40.0),
            textField.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            // button constraint
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: margin),
            button.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        avatarImage.addGestureRecognizer(tapGesture)
        
        let tapOnCloseGesture = UITapGestureRecognizer(target: self, action: #selector(tapCloseAction))
        closeButton.addGestureRecognizer(tapOnCloseGesture)
    }
    
    @objc private func tapAction() {
        let scaleFactor = self.blackView.bounds.width / avatarImage.bounds.width
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: {
                self.blackView.alpha = 0.75
                self.avatarImage.layer.borderWidth = 1.0
                self.avatarImage.layer.cornerRadius = 0.0
                self.avatarImage.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                self.avatarImage.center = self.blackView.center
                self.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    animations:  {
                        self.closeButton.alpha = 1.0
                    })
            })
    }
    
    @objc private func tapCloseAction() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            animations: {
                self.closeButton.alpha = 0.0
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.0,
                    options: [.curveEaseInOut],
                    animations: {
                        self.blackView.alpha = 0.0
                        self.avatarImage.layer.borderWidth = 3.0
                        self.avatarImage.layer.cornerRadius = self.avatarSize / 2.0
                        self.avatarImage.transform = .identity
                        self.avatarImage.center = CGPoint(x: self.avatarSize / 2.0 + self.margin, y: self.avatarSize / 2.0 + self.margin)
                    })
        })
    }
    
    @objc private func touchAction() {
        if statusText.count == 0 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.textField.backgroundColor = .red
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.textField.backgroundColor = .white
                }
            }
            return
        }
        titleLabel.text = statusText
        print("статус: \(statusText)") 
    }
    
    @objc private func editAction() {
        if let text = textField.text {
            statusText = text
        }
    }
}
