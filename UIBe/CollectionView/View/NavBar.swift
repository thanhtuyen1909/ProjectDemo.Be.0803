//
//  NavBar.swift
//  UIBe
//
//  Created by tuyen.quach on 12/04/2022.
//

import UIKit
import FrameLayoutKit

enum NavBarMode {
    case dark
    case light
}

class NavBar: UIView {
    private lazy var user = User()
    private let userNameLabel = UILabel()
    private let userScoreLabel = UILabel()
    private let scoreImage = UIImageView(image: UIImage(named: "imgScore"))
    private let lineView = UIView()
    
    private let frameLayout = StackFrameLayout(axis: .vertical)
    
    //MARK: Set color to userNameLabel và userScoreLabel
    private func setColorLabel(color: String) {
        userNameLabel.textColor = UIColor(hex: color)
        userScoreLabel.textColor = UIColor(hex: color)
    }
    
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
        
        let app = UIApplication.shared
        let height = app.statusBarFrame.size.height
        
        frameLayout + HStackLayout {
            $0 + userNameLabel
            $0.addSpace().flexible()
            $0 + VStackLayout {
                $0 + HStackLayout {
                    ($0 + userScoreLabel)
                    ($0 + scoreImage).fixedSize = CGSize(width: 25, height: 25)
                    //$0
                    $0.padding(top: 5.0, left: 8.0, bottom: 5.0, right: 8.0)
                    $0.backgroundColor = UIColor(hex: "#5E6D84", alpha: 0.35)
                }
                $0.layer.masksToBounds = true
                $0.distribution = .center
                $0.didLayoutSubviews {
                    $0.layer.cornerRadius = $0.bounds.height / 2.0
                }
            }
            $0.padding(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
        }
        frameLayout.distribution = .bottom
        frameLayout + lineView
        frameLayout.padding(top: height, left: 0, bottom: 0, right: 0)
        addSubview(frameLayout)
    }
    
    private func setupComponents() {
        userNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        userNameLabel.text = "Chào \(user.name)!"
        
        lineView.isHidden = true
        lineView.backgroundColor = .tertiarySystemGroupedBackground
        lineView.frame.size = CGSize(width: frameLayout.frame.width, height: 1.0)
        
        userScoreLabel.text = String(user.score)
        
        setColorLabel(color: DataViewController().primary_text_color_light)
    }
    
    //MARK: Set mode
    func setupNavBarMode(style: NavBarMode) {
        switch style {
        case .dark:
            frameLayout.backgroundColor = .white
            lineView.isHidden = false
            setColorLabel(color: DataViewController().primary_text_color_dark)
        case .light:
            frameLayout.backgroundColor = .clear
            lineView.isHidden = true
            setColorLabel(color: DataViewController().primary_text_color_light)
        }
    }
}
