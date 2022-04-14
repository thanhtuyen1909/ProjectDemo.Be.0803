//
//  TitleCell.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit
import FrameLayoutKit

class NativeBannerCell: UICollectionViewCell {
    //@IBOutlet weak var bannerImageView: UIImageView!
    let identifier = String(describing: "native_banner")
    let bannerImageView = UIImageView()
    var frameLayout = FrameLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return frameLayout.sizeThatFits(size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayout.frame = bounds
    }
    
    private func setupLayout() {
        frameLayout.targetView = bannerImageView
        addSubview(frameLayout)
        addSubview(bannerImageView)
    }
}
