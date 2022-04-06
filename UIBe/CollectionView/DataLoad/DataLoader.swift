//
//  DataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

//protocol HomeData {
//    var type: String { get set }
//}
//
//struct DataHome {
//    let source: [[Data]]
//}
//
//struct Service: HomeData {
//    var type: String
//    let name: String?
//    let img: String?
//}
//
//struct Location: HomeData {
//    var type: String
//}
//
//struct Banner: HomeData {
//    var type: String
//    
//    let username: String?
//    let userScore: Int?
//    let imgBanner: String?
//}

protocol DataLoader {
    func loadData(completion: @escaping (DataSession) -> Void)
}

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
}
