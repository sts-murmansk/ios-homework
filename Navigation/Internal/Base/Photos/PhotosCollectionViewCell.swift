//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Сергей Цветков on 01.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private weak var tapImageDelegate: TapImageProtocol?
    
    public let photoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        //$0.layer.cornerRadius = 6
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        photoImageView.addGestureRecognizer(tapImage)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(_ photoName: String, tapDelegate: TapImageProtocol, cornerRadius radius: CGFloat = 0.0) {
        tapImageDelegate = tapDelegate
        photoImageView.layer.cornerRadius = radius
        photoImageView.image = UIImage(named: photoName)!
    }
    
    @objc private func tapAction() {
        tapImageDelegate?.imageTaped(imageView: photoImageView)
    }
}
