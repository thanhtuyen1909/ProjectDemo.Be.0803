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
    @IBOutlet weak var suggestLocationCollectionView: UICollectionView!
    
    let sourceSuggestLocation = ["Nhà", "Công ty", "69 Đường 55, Tân Tạo", "Thanh Tuyền"]
    
    let cellIdentifier = "cell"
    
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
        
        // set collectionView
        suggestLocationCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        suggestLocationCollectionView.delegate = self
        suggestLocationCollectionView.dataSource = self
        suggestLocationCollectionView.register(UINib(nibName: "SuggestLocationCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.suggestLocationCollectionView.collectionViewLayout = layout
        
        suggestLocationCollectionView.alwaysBounceVertical = true
    }
}

extension InputLocationCell: UICollectionViewDelegate {

}

extension InputLocationCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceSuggestLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = suggestLocationCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SuggestLocationCell else{
            return UICollectionViewCell()
        }
        cell.suggestLocationLabel.text = sourceSuggestLocation[indexPath.row]
        return cell
    }
}
