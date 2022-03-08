//
//  SectionHeader.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 08/03/2022.
//

import UIKit

class SectionHeader: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countFood: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
