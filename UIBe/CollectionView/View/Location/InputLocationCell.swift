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
        // input location view
        inputLocationView.layer.cornerRadius = 5
        inputLocationView.clipsToBounds = true
        
        // text field
        setPropertiesTextField()
        
        // make view to front stackview
        lineView.layer.zPosition = 1
        
        // set collectionView
        setPropertiesCollectionView()
    }
    
    private func setPropertiesCollectionView() {
        suggestLocationCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        suggestLocationCollectionView.delegate = self
        suggestLocationCollectionView.dataSource = self
        suggestLocationCollectionView.register(UINib(nibName: "SuggestLocationCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //suggestLocationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.suggestLocationCollectionView.collectionViewLayout = layout
        
        //suggestLocationCollectionView.alwaysBoxunceVertical = true
    }
    
    private func setPropertiesTextField() {
        inputLocationTextFieldFrom.borderStyle = .none
        inputLocationTextFieldTo.borderStyle = .none
        
        inputLocationTextFieldFrom.isUserInteractionEnabled = false
        inputLocationTextFieldTo.isUserInteractionEnabled = false
        
        inputLocationTextFieldFrom.text = "Ila - Nguyễn Đình Chiểu"
        inputLocationTextFieldTo.text = "Nhập điểm đến"
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

extension InputLocationCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: suggestLocationCollectionView.frame.width, height: suggestLocationCollectionView.frame.height)
    }
}
