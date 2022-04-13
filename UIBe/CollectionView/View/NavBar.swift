//
//  NavBar.swift
//  UIBe
//
//  Created by tuyen.quach on 12/04/2022.
//

import UIKit

class NavBar: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreView: UIView!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    private lazy var user = User()
    
    //MARK: Set color to userNameLabel và userScoreLabel
    private func setColorLabel(color: String) {
        userNameLabel.textColor = UIColor(hex: color)
        userScoreLabel.textColor = UIColor(hex: color)
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
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupTopView()
    }
    
    //MARK: Set up topView
    func setupTopView() {
        lineView.isHidden = true
        
        userScoreView.clipsToBounds = true
        userScoreView.layer.cornerRadius = userScoreView.frame.height / 2
        
        userScoreLabel.text = String(user.score)
        userNameLabel.text = "Chào \(user.name)!"
        setColorLabel(color: DataViewController().primary_text_color_light)
        
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    //MARK: Set mode
    func setupNavBarMode(style: NavBarMode) {
        switch style {
        case .dark:
            contentView.backgroundColor = .white
            lineView.isHidden = false
            setColorLabel(color: DataViewController().primary_text_color_dark)
        case .light:
            contentView.backgroundColor = .clear
            lineView.isHidden = true
            setColorLabel(color: DataViewController().primary_text_color_light)
        }
    }
}
