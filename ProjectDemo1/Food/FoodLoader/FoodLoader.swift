//
//  FoodLoader.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 09/03/2022.
//

import Foundation

struct Food {
    let name: String?
    let address: String?
}

struct GroupFood {
    let name: String?
    let food: [Food]
}

protocol FoodLoader {
    func loadFood(completion: @escaping ([GroupFood]) -> Void)
}
