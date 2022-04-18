//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import Foundation
import UIKit

class BannerCellController: CellController {
    //MARK: properties
    private lazy var width = CGFloat(0)
    private lazy var ratio = 0.0
    
    var type: String = ""
    var data: [HomeSessionService] = []
    var meta_data: [String : Any] = [:]
    
    required init(type: String, data: [HomeSessionService], meta_data: [String : Any]) {
        self.type = type
        self.data = data
        self.meta_data = meta_data
    }
    
    func numberOfItemsInSections() -> Int {
        return 1
    }

    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        
        if let time = meta_data["slide_duration"] as? String {
            cell.setAutoScroll(timeInterval:  Double(time) ?? 0.0)
        } else {
            cell.setAutoScroll(timeInterval: 0.0)
        }
        
        return cell
    }
    
    func sizeForItemAt(collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        width = collectionView.frame.width
        ratio = (336 / 96)
        return CGSize(width: width, height: width / ratio)
    }
}
