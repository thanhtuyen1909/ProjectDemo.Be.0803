//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class BannerCellController: CellController {
    
//    let type: String?
//    let username: String?
//    let userScore: Int?
//    let imgBanner: String?
//
//    init(type: String?, username: String?, userScore: Int?, imgBanner: String?) {
//        self.type = type
//        self.username = username
//        self.userScore = userScore
//        self.imgBanner = imgBanner
//    }
    
    override func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath, data: HomeData) -> UICollectionViewCell {
        
        guard let banner = data as? Banner else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: banner.type, for: indexPath) as! TitleCell
        
        cell.userLabel.text = "Chào " + banner.username! + "!"
        cell.userScoreLabel.text = String(banner.userScore!)
        cell.bannerImageView.load(urlString: banner.imgBanner!)
        return cell
    }
    
    
}
