//
//  ServiceCell1.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class ServiceCell1: UICollectionViewCell {
    
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var serviceView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        serviceView.layer.cornerRadius = 5
        serviceView.clipsToBounds = true
    }
}
