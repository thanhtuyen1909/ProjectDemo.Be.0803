//
//  DataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

//MARK: create protocol to load data
protocol DataLoader {
    func loadData(completion: @escaping (DataSession) -> Void)
}

//MARK: create struct to parse data
struct DataSession {
    let source: [Session]
    let background_image: String
    let text_color: String
}

struct Session {
    var type: String
    var data: [HomeSessionService]
    var meta_data: [String: Any]
}

struct HomeSessionService {
    var name: String
    var image: String
    var label: [String: Any]
    var promoted: Int
}

struct User {
    var name = "Thanh Tuyền"
    var score = 12345
}

enum ItemType : String {
    case native_banner = "native_banner"
    case trip = "trip"
    case grid = "grid"
    case banner = "banner"
}
