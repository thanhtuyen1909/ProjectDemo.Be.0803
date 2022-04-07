//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import Foundation
import UIKit

class BannerCellController: CellController {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as? BannerCell,
            let time = meta_data["slide_duration"] as? String else {
            return UICollectionViewCell()
        }
        cell.setAutoScroll(timeInterval:  Double(time) ?? 0.0)
        return cell
    }
}
