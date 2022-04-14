//
//  BannerCell.swift
//  UIBe
//
//  Created by tuyen.quach on 06/04/2022.
//
import UIKit
import FrameLayoutKit

class BannerCell: UICollectionViewCell {
    //MARK: properties
    private var pageControl = UIPageControl()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.layer.cornerRadius = 5
        collectionView.clipsToBounds = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ContentBannerCell.self, forCellWithReuseIdentifier: ContentBannerCell().imgCellIdentifier)
        return collectionView
    }()
    

    private var frameLayout = StackFrameLayout(axis: .vertical)
    
    let identifier = String(describing: "banner")
    
    var sourceBanner = ["https://simg.zalopay.com.vn/zlp-website/assets/be_4aaf47a554.jpg", "https://imgmainsite.be.com.vn/2021/06/461a0c25-28tinh_deskbanner.png", "https://www.itjobs.com.vn/Upload/be-Group-banner.jpg"]
    
    private var timer: Timer?

    private lazy var currentCellIndex = 0
    private lazy var timeInterval = 0.0
    
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
    
    //MARK: set properties to pageControl
    private func setupPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = sourceBanner.count
        
        pageControl.layer.zPosition = 1
        
        pageControl.preferredIndicatorImage = UIImage(named: "straight")?.scalePreservingAspectRatio(targetSize: CGSize(width: 25, height: 30))
    }
    
    //MARK: set properties to collectionView
    private func setupPropertiesCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func commonInit() {
        setupPageControl()
        setupPropertiesCollectionView()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 8
        
        addSubview(pageControl)
        addSubview(frameLayout)
        
        frameLayout + collectionView
        (frameLayout + pageControl).alignment = (.bottom, .center)
        
        frameLayout.isUserInteractionEnabled = true
    }
    
    //MARK: set auto scroll with timeInterval and selector is slideToNext
    func setAutoScroll(timeInterval: Double) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    //MARK: func make collectionView scroll to item at currentCellIndex with the right direction
    @objc private func slideToNext() {
        if currentCellIndex < sourceBanner.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
}

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceBanner.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentBannerCell().imgCellIdentifier, for: indexPath) as? ContentBannerCell else {
            return UICollectionViewCell()
        }
        cell.imageView.load(urlString: sourceBanner[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let widthCell = frame.width
        let offset = scrollView.contentOffset.x / widthCell
        
        if offset > 0.5, currentCellIndex < sourceBanner.count - 1{
            collectionView.scrollToItem(at: IndexPath(item: currentCellIndex + 1, section: 0), at: .right, animated: true)
        } else {
            if currentCellIndex >= sourceBanner.count - 1 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            } else {
                collectionView.scrollToItem(at: IndexPath(item: currentCellIndex - 1, section: 0), at: .left, animated: true)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let widthCell = frame.width
        let offset = scrollView.contentOffset.x / widthCell
        
        if offset > 0.5, currentCellIndex < sourceBanner.count - 1{
            collectionView.scrollToItem(at: IndexPath(item: currentCellIndex + 1, section: 0), at: .right, animated: true)
        } else {
            if currentCellIndex >= sourceBanner.count - 1 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            } else {
                collectionView.scrollToItem(at: IndexPath(item: currentCellIndex - 1, section: 0), at: .left, animated: true)
            }
        }
    }
}

extension BannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
