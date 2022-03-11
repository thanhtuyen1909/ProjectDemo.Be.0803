//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation

class BannerCellController {
    
    let type: String?
    let username: String?
    let userScore: Int?
    let imgBanner: String?
    
    init(type: String?, username: String?, userScore: Int?, imgBanner: String?) {
        self.type = type
        self.username = username
        self.userScore = userScore
        self.imgBanner = imgBanner
    }
}
