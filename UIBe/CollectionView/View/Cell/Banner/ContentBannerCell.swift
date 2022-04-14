//
//  ContentBannerCell.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import UIKit
import FrameLayoutKit

class ContentBannerCell: UICollectionViewCell {

    let imgCellIdentifier = String(describing: "imgcell")
    let imageView = UIImageView()
    private var frameLayout = FrameLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return frameLayout.sizeThatFits(size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayout.frame = bounds
    }
    
    private func commonInit() {
        setupLayout()
        
        frameLayout.targetView = imageView
        addSubview(frameLayout)
        addSubview(imageView)
    }
    
    private func setupLayout() {
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
