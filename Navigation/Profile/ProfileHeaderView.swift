//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Цветков on 12.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    var avatarImage = UIImageView()
    var captionLabel = UILabel()
    var titleLabel = UILabel()
    var button = UIButton()
    var textField = UITextField()
    
    private let captionFontSize = 18.0
    private let titleFontSize = 14.0
    private let textFieldFontSize = 15.0
    
    private var statusText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented");
    }
    
    func setupSubviews() {
        avatarImage = createAvatar()
        captionLabel = createCaption()
        titleLabel = createTitle()
        button = createButton()
        textField = createTextField();
        
        addSubview(avatarImage)
        addSubview(captionLabel)
        addSubview(titleLabel)
        addSubview(button)
        addSubview(textField)
    }
    
    override func layoutSubviews() {
        let margin = 16.0 // общий отступ
        let avatarSize = frame.width / 4.0 // размер картинки
        let labelsLeft = margin + avatarSize + margin // отступ слева для меток
        let titleTop = margin + avatarSize + margin - 34 - titleLabel.font.lineHeight // верх нижней надписи
        let labelsWidth = frame.width - labelsLeft - margin // ширина надписей
        
        avatarImage.frame = CGRect(x: margin, y: margin, width: avatarSize, height: avatarSize)
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        
        captionLabel.frame = CGRect(x: labelsLeft, y: 27, width: labelsWidth, height: captionLabel.font.lineHeight)
        
        titleLabel.frame = CGRect(x: labelsLeft, y: titleTop, width: labelsWidth, height: titleLabel.font.lineHeight)
        
        textField.frame = CGRect (x: labelsLeft, y: titleTop + titleLabel.font.lineHeight + margin, width: labelsWidth, height: 40)
        
        button.frame = CGRect(x: margin, y: textField.frame.origin.y + 40.0 + margin, width: frame.width - 2 * margin, height: 50)
        //button.frame = CGRect(x: margin, y: labelsLeft, width: frame.width - 2 * margin, height: 50)
    }
    
    private func createAvatar() -> UIImageView {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "Cat")
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 3.0
        avatar.layer.borderColor = UIColor.white.cgColor
        return avatar
    }
    
    private func createCaption() -> UILabel {
        let label = UILabel()
        label.text = "Hipster cat"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: captionFontSize, weight: .bold)
        return label
    }
    
    private func createTitle() -> UILabel {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: captionFontSize, weight: .regular)
        return label
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
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
    }
    
    private func createTextField() -> UITextField {
        let field = UITextField()
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .regular)
        field.textColor = .black
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 12.0
        field.addTarget(self, action: #selector(editAction), for: .editingChanged)
        // добавим отступ слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = UITextField.ViewMode.always
        return field
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
