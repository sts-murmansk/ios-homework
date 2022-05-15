//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Цветков on 12.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var postModel: [[PostModel]] = PostModel.makeData()
    
    private let headerView = ProfileHeaderView()
 
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        $0.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
        
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return postModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postModel[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setupCell(postModel[indexPath.section][indexPath.row].ID, postDelegate: self)
        cell.enableCellDeleting()
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? headerView : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}

// MARK: - PostProtocol

extension ProfileViewController: PostProtocol {
    func getIndex(forID: Int) -> Int? {
        return postModel[1].firstIndex(where: { $0.ID == forID })
    }
    
    func addLike(toID: Int) -> Int {
        if let index = getIndex(forID: toID) {
            postModel[1][index].likes += 1
            tableView.reloadData()
            return postModel[1][index].likes
        }
        return 0
    }
    
    func addView(toID: Int) -> Int {
        if let index = getIndex(forID: toID) {
            postModel[1][index].views += 1
            return postModel[1][index].views
        }
        return 0
    }
    
    func deletePost(withID: Int) {
        if let index = getIndex(forID: withID) {
            postModel[1].remove(at: index)
            tableView.reloadData()
        }
    }
    
    func getData(withID: Int) -> PostModel {
        if let index = getIndex(forID: withID) {
            return postModel[1][index]
        }
        return PostModel(ID: 0, author: "", description: "", image: "", likes: 0, views: 0)
    }
    
    func viewDetail(withID: Int) {
        let postVC = PostViewController(postID: withID, postDelegate: self)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
