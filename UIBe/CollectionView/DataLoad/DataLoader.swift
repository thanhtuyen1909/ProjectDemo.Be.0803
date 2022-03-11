//
//  DataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

protocol HomeData {}

struct DataHome {
    let numberSection: Int?
    let banner: [Banner]
    let location: [Location]
    let service: [Service]
}

struct Service: HomeData {
    let type: String?
    let name: String?
    let img: String?
}

struct Location: HomeData {
    let type: String?
}

struct Banner: HomeData {
    let type: String?
    let username: String?
    let userScore: Int?
    let imgBanner: String?
}

protocol DataLoader {
    func loadData(completion: @escaping ([DataHome]) -> Void)
}
