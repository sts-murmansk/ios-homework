//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Сергей Цветков on 01.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "Photos"
        return $0
    }(UILabel())

    private let arrowImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "Arrow")
        return $0
    }(UIImageView())
    
    private lazy var firstImageView = makeImageView(name: "01")
    private lazy var secondImageView = makeImageView(name: "02")
    private lazy var thirdImageView = makeImageView(name: "03")
    private lazy var fourthImageView = makeImageView(name: "04")
    
    /*private var photos = [[
        "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
        "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"
    ]]

    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()*/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeImageView(name imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 4
        return imageView
    }
    
    private func layout() {
        //[titleLabel, arrowImageView, photosCollection].forEach { contentView.addSubview($0) }
        [titleLabel, arrowImageView, firstImageView, secondImageView, thirdImageView, fourthImageView].forEach { contentView.addSubview($0) }
          
        let margin = 12.0
        let imageMargin = 8.0
        
        NSLayoutConstraint.activate([
            // authorLabel
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor),
            // arrowImageView
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            arrowImageView.heightAnchor.constraint(equalToConstant: titleLabel.font.lineHeight),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor),
            // firstImageView
            firstImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            firstImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            firstImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -margin),
            firstImageView.widthAnchor.constraint(equalTo: firstImageView.heightAnchor),
            firstImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            // secondImageView
            secondImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
            secondImageView.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: imageMargin),
            secondImageView.widthAnchor.constraint(equalTo: firstImageView.widthAnchor),
            secondImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
            // thirdImageView
            thirdImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
            thirdImageView.leadingAnchor.constraint(equalTo: secondImageView.trailingAnchor, constant: imageMargin),
            thirdImageView.widthAnchor.constraint(equalTo: firstImageView.widthAnchor),
            thirdImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
            // fourthImageView
            fourthImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
            fourthImageView.leadingAnchor.constraint(equalTo: thirdImageView.trailingAnchor, constant: imageMargin),
            fourthImageView.widthAnchor.constraint(equalTo: firstImageView.widthAnchor),
            fourthImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor)
            /*// photosCollection
            photosCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            photosCollection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor),
            photosCollection.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -margin),
            photosCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)*/
        ])
    }
}
/*
// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photos[indexPath.section][indexPath.item], cornerRadius: 6)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { return 8 }
    private var columsCount: CGFloat { return 4 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - sideInset * (columsCount - 1)) / columsCount
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: 0, bottom: sideInset, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
*/
