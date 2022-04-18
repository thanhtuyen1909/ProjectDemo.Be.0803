//
//  ServiceCell1.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit
import FrameLayoutKit

class PromoteServiceCell: UICollectionViewCell {
    
    var serviceImageView = UIImageView()
    var serviceLabel = UILabel()
    private var notiLabel = UILabel()
    private var frameLayout = StackFrameLayout(axis: .horizontal)
    
    
    let identifier = String(describing: "promoteServiceCell")
    
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
        setupComponents()
        //setLabel(label: "Moi")
        
//        notiLabel.text = "Moi"
//        notiLabel.backgroundColor = .red
        
        (frameLayout + serviceImageView)
            .align(vertical: .center, horizontal: .none)
            .padding(top: 4, left: 0, bottom: 0, right: 0)
            .fixedContentSize = CGSize(width: 40, height: 40)
            
        frameLayout.spacing = 12
        frameLayout + serviceLabel
        frameLayout.distribution = .center
        
        frameLayout.backgroundColor = UIColor.init(hex: "#F2F5F7")
        frameLayout.clipsToBounds = true
        frameLayout.layer.cornerRadius = 5
        //frameLayout.debug = true
        addSubview(frameLayout)
    }
    
    private func setupComponents() {
        notiLabel.isHidden = true
        notiLabel.font = UIFont(name: "be Vietnam Display", size: 14)
        notiLabel.textColor = .white

        notiLabel.layer.zPosition = 1

        serviceLabel.font =
        //UIFont(name: "be Vietnam", size: 12)
            .systemFont(ofSize: 15, weight: .bold)
    }
    
    func setLabel(label: String) {
        
        notiLabel.text = label
        notiLabel.isHidden = false
        
        notiLabel.layer.borderColor = UIColor.white.cgColor
        notiLabel.layer.borderWidth = 2.0
        notiLabel.clipsToBounds = true
        
        notiLabel.layer.shadowColor = UIColor.gray.cgColor
        notiLabel.layer.shadowOpacity = 0.1
        notiLabel.layer.shadowRadius = 3
        notiLabel.textAlignment = .center
        notiLabel.textColor = .white
        notiLabel.backgroundColor = .red
        
        
        addLabelNoti()

    }
    
    private func addLabelNoti() {
        let x = bounds.size.width / 2
        let y = serviceImageView.bounds.origin.x - 4
        
        notiLabel.frame = CGRect(x:x, y:y, width: notiLabel.sizeThatFits(frame.size).width + 12, height: notiLabel.sizeThatFits(frame.size).width)
        notiLabel.layer.cornerRadius = notiLabel.frame.height / 2.0
        
        addSubview(notiLabel)
    }
}
