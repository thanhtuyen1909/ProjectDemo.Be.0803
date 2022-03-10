//
//  DataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

struct DataHome {
    let numberSection: Int?
    let banner: [Banner]
    let location: [Location]
    let service: [Service]
}

struct Service {
    let type: String?
    let name: String?
    let img: String?
}

struct Location {
    let type: String?
}

struct Banner {
    let type: String?
    let username: String?
    let userScore: Int?
    let imgBanner: String?
}

protocol DataLoader {
    func loadData(completion: @escaping ([DataHome]) -> Void)
}
