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
    
    private let imgCellIdentifier = "imgcell"
    
    private var timer: Timer?

    private lazy var currentCellIndex = 0
    private lazy var timeInterval = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // set collectionView
        setPropertiesCollectionView()
        
        // set pageControl
        setPageControl()
    }
    
    private func setPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = sourceBanner.count
        
        pageControl.preferredIndicatorImage = UIImage(named: "straight")?.scalePreservingAspectRatio(targetSize: CGSize(width: 25, height: 30))
        pageControl.setIndicatorImage(UIImage(named: "catIcon"), forPage: currentCellIndex)
    }
    
    private func setPropertiesCollectionView() {
        collectionView.layer.cornerRadius = 5
        collectionView.clipsToBounds = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ContentBannerCell", bundle: nil), forCellWithReuseIdentifier: imgCellIdentifier)
    }
    
    func setAutoScroll(timeInterval: Double) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    @objc private func slideToNext() {
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
