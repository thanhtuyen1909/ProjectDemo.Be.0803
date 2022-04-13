//
//  SuggestLocationCell.swift
//  UIBe
//
//  Created by tuyen.quach on 06/04/2022.
//

import UIKit

class SuggestLocationCell: UICollectionViewCell {
    //MARK: properties
    @IBOutlet weak var suggestLocationLabel: UILabel!
    @IBOutlet weak var suggestLocationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.suggestLocationView.clipsToBounds = true
        self.suggestLocationView.layer.cornerRadius = self.suggestLocationView.frame.height / 2
    }
}
