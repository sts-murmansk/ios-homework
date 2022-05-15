//
//  PostModel.swift
//  Navigation
//
//  Created by Сергей Цветков on 27.04.2022.
//

import UIKit

struct PostModel {
    private static var globalID = 0
    var ID: Int
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int

    static func nextID() -> Int {
        globalID += 1
        return globalID
    }
    
    static func makeData() -> [[PostModel]] {
        var model = [[PostModel]]()
        var section = [PostModel]()
        
        section.append(PostModel(ID: nextID(), author: "Porsche Cat", description: "Линейка Cayenne пополнилась еще одним представителем, обладающим невероятной мощью и точной динамикой. Cayenne Turbo GT обладает всеми необходимыми предпосылками для того, чтобы с самого начала занять лидирующие позиции.", image: "CayenneTurboGT", likes: 134, views: 280))
        section.append(PostModel(ID: nextID(), author: "Porsche Cat", description: "Идея Panamera. С типичной для Porsche динамикой и одновременно высокой экономичностью? Невозможно – говорили многие. Смело – утверждали другие.", image: "PanameraGTS", likes: 151, views: 452))
        section.append(PostModel(ID: nextID(), author: "Porsche Cat", description: "Модели 718 созданы для жизни в спортивном стиле. Это среднемоторные спортивные автомобили, которые хранят в себе спортивный дух легендарного Porsche 718 и отличаются современной техникой, демонстрируя это потрясающее сочетание на дорогах нашего мира. С одной лишь целью: добавить эмоции в будни.", image: "Cayman", likes: 198, views: 760))
        section.append(PostModel(ID: nextID(), author: "Porsche Cat in collaboration with Car Dog", description: "50 лет Porsche Design. В 1972 году профессор Ф. А. Порше – дизайнер культового 911, совершил смелый, но гениальный шаг, создав матово-черный хронограф I, который и по сей день формирует язык дизайна часов от Porsche Design", image: "Carrera", likes: 270, views: 977))
        
        model.append([PostModel]())
        model.append(section)
        
        return model
    }
}
