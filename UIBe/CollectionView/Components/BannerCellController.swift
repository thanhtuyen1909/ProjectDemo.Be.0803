//
//  BannerCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import Foundation
import UIKit

class BannerCellController: CellController {

    override func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as? BannerCell,
            let time = meta_data["slide_duration"] as? String else {
            return UICollectionViewCell()
        }
        cell.setAutoScroll(timeInterval:  Double(time) ?? 0.0)
        return cell
    }
}
