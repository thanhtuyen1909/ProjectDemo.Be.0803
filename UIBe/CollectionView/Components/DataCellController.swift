//
//  DataCellController.swift
//  UIBe
//
//  Created by tuyen.quach on 11/03/2022.
//

import Foundation
import UIKit

class DataCellController {
    
    var numberSection: Int?
    var banner: [BannerCellController]
    var location: [LocationCellController]
    var service: [ServiceCellController]
    
    init(numberSection: Int? = nil, banner: [BannerCellController], location: [LocationCellController], service: [ServiceCellController]) {
        self.numberSection = numberSection
        self.banner = banner
        self.location = location
        self.service = service
    }
    
    func dataNumberItemsOfSection(for collectionView: UICollectionView, section: Int) -> Int {
        switch section {
        case 0: return banner.count
        case 1: return location.count
        case 2: return service.count
        default: return 0
        }
    }
    
    func dataCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
        }
        if indexPath.section == 1 {
            
        }
        
        if service[indexPath.row].type == "ServiceCell1" {
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceController(at: indexPath).type ?? "", for: indexPath) as! ServiceCell2
        cell.serviceLabel.text = service[indexPath.row].name
        loadImage(image_url: serviceController(at: indexPath).img!, imageView: cell.serviceImageView)
        return cell
    }
    
    func loadImage(image_url: String, imageView: UIImageView){
        let url = URL(string: image_url)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
    }
    
    private func serviceController(at indexPath: IndexPath) -> ServiceCellController {
        service[indexPath.row]
    }
//
//    private func bannerController() -> BannerCellController {
//        banner
//    }
    
    func setStyle() {
        
    }
}
