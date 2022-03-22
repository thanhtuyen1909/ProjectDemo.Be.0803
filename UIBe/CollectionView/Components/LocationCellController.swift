//
//  LocationCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class LocationCellController: CellController {
//    let type: String?
//    
//    init(type: String?) {
//        self.type = type
//    }
    
    override func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath, data: HomeData) -> UICollectionViewCell {
        
        guard let location = data as? Location else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: location.type, for: indexPath) as! InputLocationCell
        return cell
    }
}

