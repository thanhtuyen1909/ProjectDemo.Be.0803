//
//  ServiceCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class ServiceCellController: CellController {
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
        if(indexPath.row < 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell1", for: indexPath) as! ServiceCell1
            
            cell.serviceView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.serviceLabel.text = data[indexPath.row].name
            cell.serviceImageView.load(urlString: data[indexPath.row].image)
            
            
            if indexPath.row == 0 {
                if(cell.rightView != nil) {
                    cell.rightView.removeFromSuperview()
                    cell.serviceView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
                }
            }
            else {
                if(cell.leftView != nil) {
                    cell.leftView.removeFromSuperview()
                    cell.serviceView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
                }
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell2", for: indexPath) as! ServiceCell2
        cell.serviceLabel.text = data[indexPath.row].name
        cell.serviceImageView.load(urlString: data[indexPath.row].image)
        
        if let label = data[indexPath.row].label["vi"] as? String {
            cell.notiLabel.text = label
            cell.notiView.isHidden = false
        }
        
        return cell
    }
    
    func sizeForItemAt(view: UIView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < 2 {
            width = (view.frame.width / 2) - 10
        }
        else {
            width = (view.frame.width / 4) - 15
        }
        ratio = (160 / 64)
        return CGSize(width: width, height: Double((view.frame.width / 2)) / ratio)
    }
}
