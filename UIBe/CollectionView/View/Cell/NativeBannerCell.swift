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
        frameLayout.targetView = bannerImageView
        addSubview(frameLayout)
        addSubview(bannerImageView)
    }
}
