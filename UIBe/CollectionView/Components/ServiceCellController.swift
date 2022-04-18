//
//  ServiceCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import UIKit

class ServiceCellController: CellController {
    //MARK: properties
    var type: String = ""
    var data: [HomeSessionService] = []
    var meta_data: [String : Any] = [:]
    
    private lazy var width = CGFloat(0)
    private lazy var ratio = 0.0
    
    required init(type: String, data: [HomeSessionService], meta_data: [String : Any]) {
        self.type = type
        self.data = data
        self.meta_data = meta_data
    }
    
    
    func numberOfItemsInSections() -> Int {
        if data.count > 8 {
            return 10
        }
        return data.count
    }
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if(data[indexPath.row].promoted == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoteServiceCell().identifier, for: indexPath) as! PromoteServiceCell
            
            cell.serviceLabel.text = data[indexPath.row].name
            cell.serviceImageView.load(urlString: data[indexPath.row].image)
            
            // If label exist -> notiView is display
            if let label = data[indexPath.row].label["vi"] as? String {
                cell.setLabel(label: label)
            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalServiceCell().identifier, for: indexPath) as! NormalServiceCell
            cell.serviceLabel.text = data[indexPath.row].name
            cell.serviceImageView.load(urlString: data[indexPath.row].image)
            
            // If label exist -> notiView is display
            if let label = data[indexPath.row].label["vi"] as? String {
                cell.setLabel(label: label)
            }
            
            return cell
        }
    }
    
    func sizeForItemAt(view: UIView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < 2 {
            width = (view.frame.width / 2) - 10
        }
        else {
            width = (view.frame.width / 4) - 15
        }
        ratio = (160 / 64)
        return CGSize(width: width, height: Double((view.frame.width / 2) ) / ratio)
    }
}
