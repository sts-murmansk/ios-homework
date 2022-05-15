//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Сергей Цветков on 27.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private var cellDeletingEnabled = false
    private weak var postDelegate: PostProtocol?
    private var postID: Int = 0

    private let authorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 2
        $0.text = "Author"
        return $0
    }(UILabel())

    private let postImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
        $0.text = "Description"
        return $0
    }(UILabel())
    
    private let likesLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.isUserInteractionEnabled = true
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "Likes"
        return $0
    }(UILabel())

    private let viewsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "Views"
        return $0
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupGestures()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableCellDeleting() {
        cellDeletingEnabled = true
    }
    
    func setupCell(_ postID: Int, postDelegate: PostProtocol?) {
        self.postDelegate = postDelegate
        self.postID = postID
        if let postDelegate = postDelegate {
            let postData = postDelegate.getData(withID: postID)
            authorLabel.text = postData.author
            if let image = UIImage(named: postData.image) {
                postImageView.image = image
            }
            descriptionLabel.text = postData.description
            likesLabel.text = "Likes: \(postData.likes)"
            viewsLabel.text = "Views: \(postData.views)"
        }
    }
        
    private func layout() {
        [authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
            
        let margin = 16.0
            
        NSLayoutConstraint.activate([
            // authorLabel
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            // postImageView
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: margin),
            descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            // likesLabel
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: margin),
            likesLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            // viewsLabel
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: margin),
            viewsLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
    }
    
    private func setupGestures() {
        let tapOnLike = UITapGestureRecognizer(target: self, action: #selector(tapOnLike))
        likesLabel.addGestureRecognizer(tapOnLike)
        
        let tapOnPhoto = UITapGestureRecognizer(target: self, action: #selector(tapOnPhoto))
        postImageView.addGestureRecognizer(tapOnPhoto)
        
        let swipeOnSelf = UISwipeGestureRecognizer(target: self, action: #selector(swipeOnSelf))
        swipeOnSelf.direction = .left
        addGestureRecognizer(swipeOnSelf)
    }
    
    @objc private func tapOnLike() {
        if let postDelegate = postDelegate {
            likesLabel.text = "Likes: \(postDelegate.addLike(toID: postID))"
        }
    }
    
    @objc private func tapOnPhoto() {
        if let postDelegate = postDelegate {
            viewsLabel.text = "Views: \(postDelegate.addView(toID: postID))"
            postDelegate.viewDetail(withID: postID)
        }
    }
    
    @objc private func swipeOnSelf() {
        if let postDelegate = postDelegate {
            if cellDeletingEnabled {
                postDelegate.deletePost(withID: postID)
            }
        }
    }
}
