//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import Foundation
import UIKit

class BannerCellController: CellController {
    
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
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 8
        return cell
    }
    
    func sizeForItemAt(view: UIView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        width = view.frame.width - 40
        ratio = (336 / 96)
        return CGSize(width: width, height: width / ratio)
    }
}
