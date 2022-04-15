//
//  ServiceCell2.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit
import FrameLayoutKit

class NormalServiceCell: UICollectionViewCell {
    var serviceImageView = UIImageView()
    var serviceLabel = UILabel()
    private var notiLabel = UILabel()
    private var frameLayout = StackFrameLayout(axis: .vertical)
    
    
    let identifier = String(describing: "normalServiceCell")
    
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
        
        notiLabel.text = "Moi"
        notiLabel.backgroundColor = .red
        
        (frameLayout + serviceImageView)
            .align(vertical: .none, horizontal: .center)
            .padding(top: 4, left: 0, bottom: 0, right: 0)
            .fixedContentSize = CGSize(width: 40, height: 40)
        frameLayout.spacing = 8
        (frameLayout + serviceLabel).align(vertical: .fit, horizontal: .center)
        frameLayout.distribution = .center
        
        frameLayout.debug = true
        addSubview(frameLayout)
    }
    
//
//    //MARK: set properties to NotiView
//    private func setupNotiView() {
//        notiView.layer.cornerRadius = notiView.frame.height / 2
//        notiView.layer.borderColor = UIColor.white.cgColor
//        notiView.layer.borderWidth = 1.0
//        notiView.clipsToBounds = true
//
//        notiView.layer.masksToBounds = false
//        notiView.layer.shadowColor = UIColor.gray.cgColor
//        notiView.layer.shadowOpacity = 0.1
//        //cell.layer.shadowOffset = CGSize(width: 3, height: 3)
//        notiView.layer.shadowRadius = 3
//
//        notiView.isHidden = true
//    }
    
    private func setupComponents() {
        //notiLabel.isHidden = true
        notiLabel.font = .systemFont(ofSize: 10, weight: .medium)
        notiLabel.textColor = .white

        notiLabel.layer.zPosition = 1
        
        serviceLabel.font = .systemFont(ofSize: 15)
    }
    
    func setLabel(label: String) {
        notiLabel.text = label
        //notiLabel.isHidden = false
    }
    
//    //MARK: set properties to NotiView
//    private func setupNotiView() {
//        notiView.layer.cornerRadius = notiView.frame.height/2
//        notiView.layer.borderColor = UIColor.white.cgColor
//        notiView.layer.borderWidth = 2.0
//        notiView.clipsToBounds = true
//
//        notiView.layer.masksToBounds = false
//        notiView.layer.shadowColor = UIColor.gray.cgColor
//        notiView.layer.shadowOpacity = 0.1
//        //cell.layer.shadowOffset = CGSize(width: 3, height: 3)
//        notiView.layer.shadowRadius = 3
//
//        notiView.isHidden = true
//    }
}
