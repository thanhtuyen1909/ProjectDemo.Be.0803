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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerController(at: indexPath).type ?? "", for: indexPath) as! TitleCell
            
            cell.userLabel.text = "Chào " + bannerController(at: indexPath).username! + " !"
            cell.userScoreLabel.text = String(bannerController(at: indexPath).userScore!)
            loadImage(image_url: bannerController(at: indexPath).imgBanner!, imageView: cell.bannerImageView)
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: location[indexPath.row].type ?? "", for: indexPath) as! InputLocationCell
            
            return cell
        }
        
        if service[indexPath.row].type == "ServiceCell1" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceController(at: indexPath).type ?? "", for: indexPath) as! ServiceCell1
            cell.serviceLabel.text = service[indexPath.row].name
            loadImage(image_url: serviceController(at: indexPath).img!, imageView: cell.serviceImageView)
            
            if indexPath.row == 0 {
                cell.serviceView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
                //cell.serviceView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 15).isActive = true
            }
            cell.serviceView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
            return cell
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
    
    private func bannerController(at indexPath: IndexPath) -> BannerCellController {
        banner[indexPath.row]
    }
    
    func setStyle() {
        
    }
}
