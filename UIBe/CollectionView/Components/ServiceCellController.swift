//
//  ServiceCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class ServiceCellController: CellController {
//    let type: String?
//    let img: String?
//    let name: String?
//
//    init(type: String?, img: String?, name: String?) {
//        self.type = type
//        self.img = img
//        self.name = name
//    }
//
    override func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath, data: HomeData) -> UICollectionViewCell {
        
        guard let service = data as? Service else {
            return UICollectionViewCell()
        }
        
        if(service.type == "ServiceCell1") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: service.type, for: indexPath) as! ServiceCell1
            cell.serviceLabel.text = service.name
            cell.serviceImageView.load(urlString: service.img!)
            
            if indexPath.row == 0 {
                cell.serviceView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
            }
            cell.serviceView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: service.type, for: indexPath) as! ServiceCell2
        cell.serviceLabel.text = service.name
        cell.serviceImageView.load(urlString: service.img!)
        return cell
    }
}
