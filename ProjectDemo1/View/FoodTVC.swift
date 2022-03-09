//
//  FoodTVC.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 07/03/2022.
//

import UIKit

class FoodTVC: UITableViewCell {

    @IBOutlet weak var foodView: UIStackView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodAddress: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let path = UIBezierPath(rect: .zero)
//        path.move(to: CGPoint(x: 2, y: 3))
//        path.addLine(to: CGPoint(x: 2, y: 8))
//        path.addLine(to: CGPoint(x: 3, y: 10))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        layer.shadowPath = path.cgPath
//
//        let testWindow = UIWindow(frame: UIScreen.main.bounds)
//        testWindow.rootViewController = UIViewController()
//        testWindow.makeKeyAndVisible()
        
        ratingLabel.layer.cornerRadius = 10
        ratingLabel.clipsToBounds = true
        
        foodImg.layer.cornerRadius = 10
        foodImg.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        let path = UIBezierPath()
//        let lay = CAShapeLayer()
        //awakeFromNib
        
    }

}
