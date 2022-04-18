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
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented");
    }
    
    func setupSubviews() {
        initAvatar()
        initCaption()
        initTitle()
        initButton()
        initTextField()
        
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
    
    private func initAvatar() {
        avatarImage.image = UIImage(named: "Cat")
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderWidth = 3.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
    }
    
    private func initCaption() {
        captionLabel.text = "Hipster cat"
        captionLabel.textColor = .black
        captionLabel.font = UIFont.systemFont(ofSize: captionFontSize, weight: .bold)
    }
    
    private func initTitle() {
        titleLabel.text = "Waiting for something..."
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: captionFontSize, weight: .regular)
    }
    
    private func initButton() {
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .init(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
    }
    
    private func initTextField() {
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
