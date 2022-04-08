//
//  ContentBannerCell.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import UIKit

class ContentBannerCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

    }
}
