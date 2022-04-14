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
//    @IBOutlet var contentView: UIView!
//    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var userScoreView: UIView!
//    @IBOutlet weak var userScoreLabel: UILabel!
//    @IBOutlet weak var lineView: UIView!
//    
    private lazy var user = User()
    
    private let contentView1 = UIView()
    private let userNameLabel1 = UILabel()
    private let userScoreView1 = UIView()
    private let userScoreLabel1 = UILabel()
    private let lineView1 = UIView()
    
    //MARK: Set color to userNameLabel và userScoreLabel
    private func setColorLabel(color: String) {
        userNameLabel1.textColor = UIColor(hex: color)
        userScoreLabel1.textColor = UIColor(hex: color)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        addSubview(contentView)
        contentView1.frame = self.bounds
        contentView1.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupTopView()
    }
    
    //MARK: Set up topView
    func setupTopView() {
        lineView1.isHidden = true
        
        userScoreView1.clipsToBounds = true
        userScoreView1.layer.cornerRadius = userScoreView.frame.height / 2
        
        userScoreLabel1.text = String(user.score)
        userNameLabel1.text = "Chào \(user.name)!"
        setColorLabel(color: DataViewController().primary_text_color_light)
        
        contentView1.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView1.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    //MARK: Set mode
    func setupNavBarMode(style: NavBarMode) {
        switch style {
        case .dark:
            contentView1.backgroundColor = .white
            lineView1.isHidden = false
            setColorLabel(color: DataViewController().primary_text_color_dark)
        case .light:
            contentView1.backgroundColor = .clear
            lineView1.isHidden = true
            setColorLabel(color: DataViewController().primary_text_color_light)
        }
    }
}
