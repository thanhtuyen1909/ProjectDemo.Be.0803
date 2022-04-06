//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class NativeBannerCellController: CellController {

    override func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
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
