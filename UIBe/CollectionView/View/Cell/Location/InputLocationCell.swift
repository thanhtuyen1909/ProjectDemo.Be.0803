//
//  InputLocationCell.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit
import FrameLayoutKit

class InputLocationCell: UICollectionViewCell {
    //MARK: properties
    private var fromLabel = UILabel()
    private var lineView = UIView()
    private var toLabel = UILabel()
    private var fromImageView = UIImageView(image: UIImage(named: "ride"))
    private var toImageView = UIImageView(image: UIImage(named: "Icon"))
    
    private var suggestLocationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(SuggestLocationCell.self, forCellWithReuseIdentifier: SuggestLocationCell().cellIdentifier)
        return collectionView
    }()
    
    private let frameLayout = StackFrameLayout(axis: .vertical)
    
    let sourceSuggestLocation = ["Nhà", "Công ty", "69 Đường 55, Tân Tạo", "Thanh Tuyền"]
    
    let identifier = String(describing: "trip")

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return frameLayout.sizeThatFits(size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayout.frame = bounds
    }
    
    private func commonInit() {
        // call func set properties to text field
        setPropertiesTextField()
        
        // make view to front stackview
        lineView.layer.zPosition = 1
        lineView.backgroundColor = .tertiarySystemGroupedBackground
        lineView.frame.size = CGSize(width: frame.width - 70, height: 1.0)
        
        setupCollectionView()
        
        frameLayout + HStackLayout {
            ($0 + fromImageView).extendSize = CGSize(width: 10, height: 10)
            ($0 + fromLabel).flexible()
            $0.spacing = 12
            $0.padding(top: 12, left: 17, bottom: 12, right: 17)
        }
        
        (frameLayout + lineView)
            .padding(top: 0, left: 0, bottom: 0, right: 12)
            .alignment = (.center, .right)
        
        
        frameLayout + HStackLayout {
            ($0 + toImageView).extendSize = CGSize(width: 10, height: 10)
            ($0 + toLabel).flexible()
            $0.spacing = 12
            $0.padding(top: 12, left: 17, bottom: 12, right: 17)
        }
        
        frameLayout + suggestLocationCollectionView
        
        frameLayout.clipsToBounds = true
        frameLayout.layer.cornerRadius = 10
        frameLayout.backgroundColor = .white
        frameLayout.padding(top: 12, left: 0, bottom: 0, right: 0)
        
        addSubview(frameLayout)
        //frameLayout.debug = true
    }
    
    private func setupCollectionView() {
        suggestLocationCollectionView.delegate = self
        suggestLocationCollectionView.dataSource = self
    }
    
    //MARK: set properties to TextField
    private func setPropertiesTextField() {
        fromLabel.font = .systemFont(ofSize: 14, weight: .bold)
        fromLabel.isUserInteractionEnabled = false
        fromLabel.text = "Ila - Nguyễn Đình Chiểu"
        
        toLabel.font = .systemFont(ofSize: 14)
        toLabel.isUserInteractionEnabled = false
        toLabel.text = "Nhập điểm đến"
    }
}

extension InputLocationCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceSuggestLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = suggestLocationCollectionView.dequeueReusableCell(withReuseIdentifier: SuggestLocationCell().cellIdentifier, for: indexPath) as? SuggestLocationCell else{
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
