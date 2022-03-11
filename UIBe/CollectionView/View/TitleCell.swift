//
//  TitleCell.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var userScoreLabel: UILabel!
    
    
    @IBOutlet weak var userScoreView: UIView!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userScoreView.clipsToBounds = true
        userScoreView.layer.cornerRadius = 18
    }

}
