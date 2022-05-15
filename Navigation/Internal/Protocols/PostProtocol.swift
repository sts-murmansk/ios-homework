//
//  PostProtocol.swift
//  Navigation
//
//  Created by Сергей Цветков on 15.05.2022.
//

import Foundation

protocol PostProtocol: AnyObject {
    func addLike(toID: Int) -> Int
    func addView(toID: Int) -> Int
    func deletePost(withID: Int)
    func getData(withID: Int) -> PostModel
    func viewDetail(withID: Int)
}
