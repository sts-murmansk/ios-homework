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

    private let avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(named: "Cat")
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderWidth = 3.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.cornerRadius = 50
        return avatarImage
    }()
    
    private lazy var captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.text = "Hipster cat"
        captionLabel.textColor = .black
        captionLabel.font = UIFont.systemFont(ofSize: captionFontSize, weight: .bold)
        return captionLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Waiting for something..."
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: captionFontSize, weight: .regular)
        return titleLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .init(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .regular)
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.addTarget(self, action: #selector(editAction), for: .editingChanged)
        // добавим отступ слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    private var statusText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented");
    }
    
    private func layout() {
        [avatarImage, captionLabel, titleLabel, button, textField].forEach { addSubview($0) }
 
        let margin = 16.0
        NSLayoutConstraint.activate([
            // avatar constraint
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            avatarImage.heightAnchor.constraint(equalToConstant: 100.0),
            avatarImage.widthAnchor.constraint(equalToConstant: 100.0),
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
    
    @objc private func touchAction() {
        titleLabel.text = statusText
        print("статус")
    }
    
    @objc private func editAction() {
        if let text = textField.text {
            statusText = text
        }
    }
}
