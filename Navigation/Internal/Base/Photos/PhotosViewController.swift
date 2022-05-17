//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 01.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var photos = [[
        "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", //"30",
        "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"
    ]]

    private let blackView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    private lazy var closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "xmark.square"), for: .normal)
        $0.alpha = 0.0
        $0.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var bigImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "xmark.square")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.alpha = 0.0
        return $0
    }(UIImageView())
    
    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func layout() {
        view.backgroundColor = .white
        title = "Photo gallery"
        [photosCollection, blackView, bigImageView, closeButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            // photosCollection
            photosCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // blackView
            blackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            blackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // bigImageView
            bigImageView.topAnchor.constraint(equalTo: blackView.topAnchor),
            bigImageView.leadingAnchor.constraint(equalTo: blackView.leadingAnchor),
            bigImageView.widthAnchor.constraint(equalTo: blackView.widthAnchor),
            bigImageView.bottomAnchor.constraint(equalTo: blackView.bottomAnchor),
            // closeButton
            closeButton.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 10.0),
            closeButton.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 40.0),
            closeButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    @objc private func closeAction() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: {
                self.blackView.alpha = 0.0
                self.bigImageView.alpha = 0.0
                self.closeButton.alpha = 0.0
            })
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photos[indexPath.section][indexPath.item], tapDelegate: self)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { return 8 }
    private var columsCount: CGFloat { return 3 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - sideInset * (columsCount + 1)) / columsCount
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.item)
    }
}

// MARK: - TapImageProtocol

extension PhotosViewController: TapImageProtocol {
    
    func imageTaped(imageView: UIImageView) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        bigImageView.image = imageView.image
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: {
                self.blackView.alpha = 0.75
                self.bigImageView.alpha = 1.0
             }, completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    animations:  {
                        self.closeButton.alpha = 1.0
                    })
            })
    }
}
