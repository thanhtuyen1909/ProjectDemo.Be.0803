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
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var notiView: UIView!
    @IBOutlet weak var notiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        serviceView.layer.masksToBounds = false
        serviceView.layer.cornerRadius = 8
        
        setupNotiView()
    }
    
    private func setupNotiView() {
        notiView.layer.cornerRadius = notiView.frame.height / 2
        notiView.layer.borderColor = UIColor.white.cgColor
        notiView.layer.borderWidth = 1.0
        notiView.clipsToBounds = true
        
        notiView.layer.masksToBounds = false
        notiView.layer.shadowColor = UIColor.gray.cgColor
        notiView.layer.shadowOpacity = 0.1
        //cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        notiView.layer.shadowRadius = 3
        
        notiView.isHidden = true
    }
}
