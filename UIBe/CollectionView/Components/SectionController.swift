//
//  SectionController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class SectionController {
    
    var source: [[HomeData]]
    
    init(source: [[HomeData]]) {
        self.source = source
    }
    
    func numberOfItemsInSections() -> Int {
        return source[0].count
    }
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        if let banner = source[0][indexPath.row] as? Banner {
//
//            let bannerCellController = BannerCellController(type: banner.type, username: banner.username, userScore: banner.userScore, imgBanner: banner.imgBanner)
//            return bannerCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath)
//        }
//        if let location = source[0][indexPath.row] as? Location {
//            let locationCellController = LocationCellController(type: location.type)
//            return locationCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath)
//        }
//        let service = source[0][indexPath.row] as! Service
//        let serviceCellController = ServiceCellController(type: service.type, img: service.img, name: service.name)
//        return serviceCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath)
        
        let cell = CellController()
        return cell.cellForItemAtIndex(for: collectionView, indexPath: indexPath, data: source[0][indexPath.row])
    }
    
}
