//
//  CellController.swift
//  UIBe
//
//  Created by tuyen.quach on 16/03/2022.
//
import UIKit

class CellController {
    
    var type: String
    var data: [HomeSessionService]
    var meta_data: [String: Any]
    
    init(type: String, data: [HomeSessionService], meta_data: [String : Any]) {
        self.type = type
        self.data = data
        self.meta_data = meta_data
    }
    
    func numberOfItemsInSections() -> Int {
        guard let stringCount = meta_data["service_icon_threshold"] as? String,
            let count = Int(stringCount)
        else {
            return 1
        }
        return count + 2
    }
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

