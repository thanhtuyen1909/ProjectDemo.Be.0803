//
//  BannerCell.swift
//  UIBe
//
//  Created by tuyen.quach on 06/04/2022.
//
import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sourceBanner = [UIImage(named: "img1"), UIImage(named: "img2")]
    
    let imgCellIdentifier = "imgcell"
    
    var timer: Timer?

    var currentCellIndex = 0
    var timeInterval = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set collectionView
        collectionView.layer.cornerRadius = 8
        collectionView.clipsToBounds = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ContentBannerCell", bundle: nil), forCellWithReuseIdentifier: imgCellIdentifier)
        
        // set pageControl
        pageControl.currentPage = 0
        pageControl.numberOfPages = sourceBanner.count
    }
    
    func setAutoScroll(timeInterval: Double) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    @objc func slideToNext() {
        if currentCellIndex < sourceBanner.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
}

extension BannerCell: UICollectionViewDelegate {
    
}

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgCellIdentifier, for: indexPath) as? ContentBannerCell else{
            return UICollectionViewCell()
        }
        cell.imageView.image = sourceBanner[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}

extension BannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}