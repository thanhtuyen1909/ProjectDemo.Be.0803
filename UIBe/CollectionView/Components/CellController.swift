//
//  CellController.swift
//  UIBe
//
//  Created by tuyen.quach on 16/03/2022.
//

import Foundation
import UIKit

class CellController {
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath, data: HomeData) -> UICollectionViewCell {
        if data is Banner {
            let bannerCellController = BannerCellController()
            return bannerCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath, data: data)
        }
        if data is Location {
            let locationCellController = LocationCellController()
            return locationCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath, data: data)
        }
        let serviceCellController = ServiceCellController()
        return serviceCellController.cellForItemAtIndex(for: collectionView, indexPath: indexPath, data: data)
    }
}
