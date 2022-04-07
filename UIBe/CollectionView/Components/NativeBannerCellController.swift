//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class NativeBannerCellController: CellController {
    var type: String = ""
    var data: [HomeSessionService] = []
    var meta_data: [String : Any] = [:]
    
    required init(type: String, data: [HomeSessionService], meta_data: [String : Any]) {
        self.type = type
        self.data = data
        self.meta_data = meta_data
    }
    
    func numberOfItemsInSections() -> Int {
        if data.count == 0 {
            return 1
        }
        return data.count
    }
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as! NativeBannerCell
        guard let img = meta_data["image"] as? String else {
            return UICollectionViewCell()
        }
//        cell.userLabel.text = "Chào \(name)!"
//        cell.userScoreLabel.text = score
        cell.bannerImageView.load(urlString: img)
        return cell
    }
    
    
}
