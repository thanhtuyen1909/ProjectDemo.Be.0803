//
//  InputLocationCell.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class InputLocationCell: UICollectionViewCell {
    @IBOutlet weak var inputLocationView: UIView!
    @IBOutlet weak var inputLocationTextFieldFrom: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var inputLocationTextFieldTo: UITextField!
    @IBOutlet weak var sourceLocationCollectionView: UICollectionView!
    
    let sourceLocation = ["Nhà", "Công ty", "69 Đường 55, Tân Tạo", "Thanh Tuyền"]
    
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
        
        sourceLocationCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sourceLocationCollectionView.delegate = self
        sourceLocationCollectionView.dataSource = self
        
    }
}

extension InputLocationCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}

extension InputLocationCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sourceLocationCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

//extension InputLocationCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width - 40, height: 120)
//    }
//
//}
