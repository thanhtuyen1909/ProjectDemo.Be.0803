//
//  SuggestLocationCell.swift
//  UIBe
//
//  Created by tuyen.quach on 06/04/2022.
//

import UIKit
import FrameLayoutKit

class SuggestLocationCell: UICollectionViewCell {
    //MARK: properties
    var suggestLocationLabel = UILabel()
    private var frameLayout = FrameLayout()
    let cellIdentifier = "cell"
    
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
        
        frameLayout.targetView = suggestLocationLabel
        frameLayout.extendSize = CGSize(width: Double(suggestLocationLabel.frame.width + 32.0), height: 32.0)
        frameLayout.padding(top: 8, left: 5.0, bottom: 8, right: 5.0)
        
        frameLayout.didLayoutSubviews {[weak self]_ in
            self?.suggestLocationLabel.layer.cornerRadius = (self?.suggestLocationLabel.bounds.height ?? 0.0 + 10) / 2.0
        }

        addSubview(frameLayout)
        addSubview(suggestLocationLabel)
    }

    private func setupLayout() {
        suggestLocationLabel.font = .systemFont(ofSize: 15, weight: .bold)
        suggestLocationLabel.textAlignment = .center
        suggestLocationLabel.backgroundColor = UIColor.init(hex: "#F2F5F7")
        suggestLocationLabel.layer.masksToBounds = true
    }
}
