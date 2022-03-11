//
//  InputLocationCell.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class InputLocationCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//    }
    @IBOutlet weak var inputLocationView: UIView!
    @IBOutlet weak var inputLocationTextFieldFrom: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var inputLocationTextFieldTo: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputLocationView.layer.cornerRadius = 5
        inputLocationView.clipsToBounds = true
        
        // text field
        inputLocationTextFieldFrom.borderStyle = .none
        inputLocationTextFieldTo.borderStyle = .none
        
        inputLocationTextFieldFrom.isUserInteractionEnabled = false
        inputLocationTextFieldTo.isUserInteractionEnabled = false
        
        inputLocationTextFieldFrom.text = "Ila - Nguyễn Đình Chiểu"
        inputLocationTextFieldTo.text = "Nhập điểm đến"
        
        // make view to front stackview
        lineView.layer.zPosition = 1
        
    }
}
