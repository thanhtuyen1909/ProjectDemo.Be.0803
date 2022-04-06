//
//  ServiceCell2.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class ServiceCell2: UICollectionViewCell {
    
    @IBOutlet weak var serviceImageView: UIImageView!
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var notiView: UIView!
    @IBOutlet weak var notiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notiView.layer.cornerRadius = notiView.frame.height/2
        notiView.layer.borderColor = UIColor.white.cgColor
        notiView.layer.borderWidth = 2.0
        notiView.clipsToBounds = true
        
        notiView.isHidden = true
    }
    
}
