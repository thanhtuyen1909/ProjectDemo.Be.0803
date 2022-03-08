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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
