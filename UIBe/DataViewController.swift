//
//  ViewController.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class DataViewController: UIViewController {
    
    //MARK: properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreView: UIView!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    private var loader: DataLoader? = MockDataLoader()
    private var source = [CellController]()
    
    private lazy var startY = 0.0
    private lazy var name = "Thanh Tuyền"
    private lazy var score = 12345
    private lazy var primary_text_color_dark = "#081F42"
    private lazy var primary_text_color_light = "#FFFFFF"
    
    private lazy var bottomView: UIView = {
        let btView = UIView()
        btView.layer.cornerRadius = 10
        btView.clipsToBounds = true
        btView.backgroundColor = .white
        btView.translatesAutoresizingMaskIntoConstraints = false
        return btView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up CollectionView, TopView
        setupCollectionView()
        setupTopView()
        
        /// call func addBottomView
        addBottomView()
        
        /// call func loadData
        loadData()
    }
    
    /// Load data from api parse to CellController and reloadData of collectionView
    private func loadData() {
        loader?.loadData(completion: { [weak self] data in
            self?.source = data.source.map({
                item in
                switch item.type {
                case "native_banner":
                    return NativeBannerCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                case "trip":
                    return LocationCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                case "grid":
                    return ServiceCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                default:
                    return BannerCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                }
            })
            //            if Thread.isMainThread {
            //                collectionView.reloadData()
            //            } else {
            //                DispatchQueue.main.async { [weak self] in
            //                    self?.collectionView.reloadData()
            //                }
            //            }
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.setBackgroundView(bg: data.background_image)
            }
        })
    }
}

extension DataViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberItems = source[section].numberOfItemsInSections()
        return numberItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = source[indexPath.section].cellForItemAtIndex(for: collectionView, indexPath: indexPath)
        
        // set startY and setBottomView
        if source[indexPath.section].type == "grid" && indexPath.row == 0 {
            let originInRootView = collectionView.convert(cell.frame.origin, to: self.view)
            setBottomView(y: Double(originInRootView.y) - 10, height: view.frame.height - Double(originInRootView.y) - 10)
            self.startY = Double(originInRootView.y) - 10
        }
        
        return cell
    }
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y / (((view.frame.width - 40) / (336 / 96)) + 30)
        let y = view.frame.height - (startY - scrollView.contentOffset.y)
        let h = view.frame.height - y
        
        if offset > 1 {
            topView.backgroundColor = .white
            lineView.isHidden = false
            setColorLabel(color: primary_text_color_dark)
        } else {
            topView.backgroundColor = .clear
            lineView.isHidden = true
            setColorLabel(color: primary_text_color_light)
        }
        setBottomView(y: h, height: y)
    }
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return source[indexPath.section].sizeForItemAt(view: view, sizeForItemAt: indexPath)
    }
}

extension DataViewController {
    
    /// set frame to bottomView in background
    private func setBottomView(y: Double, height: Double) {
        bottomView.frame = CGRect(x: view.frame.origin.x, y: y, width: view.frame.width, height: height)
        
        if bottomView.isHidden == true {
            bottomView.isHidden = false
        }
    }
    
    /// set up background view
    private func setBackgroundView(bg: String) {
        let image = UIImageView(frame: view.frame)
        image.contentMode = .scaleAspectFill
        image.load(urlString: bg)
        view.insertSubview(image, at: 0)
    }
    
    /// set color to userNameLabel và userScoreLabel
    private func setColorLabel(color: String) {
        userNameLabel.textColor = UIColor(hex: color)
        userScoreLabel.textColor = UIColor(hex: color)
    }
    
    /// set up topView
    private func setupTopView() {
        lineView.isHidden = true
        
        userScoreView.clipsToBounds = true
        userScoreView.layer.cornerRadius = 18
        
        userScoreLabel.text = String(score)
        userNameLabel.text = "Chào \(name)!"
        userNameLabel.textColor = UIColor(hex: primary_text_color_light)
        userScoreLabel.textColor = UIColor(hex: primary_text_color_light)
        
//        if #available(iOS 13.0, *) {
//            let window = UIApplication.shared.windows.first
//            let topPadding = window?.safeAreaInsets.top
//            topView.frame.size.height = CGFloat(80 + CGFloat(topPadding ?? 0.0))
//        }
        
    }
    
    /// set up collectionView and register cell in collectionView
    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(UINib(nibName:"NativeBannerCell", bundle: nil), forCellWithReuseIdentifier: "native_banner")
        collectionView.register(UINib(nibName:"InputLocationCell", bundle: nil), forCellWithReuseIdentifier: "trip")
        collectionView.register(UINib(nibName:"ServiceCell1", bundle: nil), forCellWithReuseIdentifier: "ServiceCell1")
        collectionView.register(UINib(nibName:"ServiceCell2", bundle: nil), forCellWithReuseIdentifier: "ServiceCell2")
        collectionView.register(UINib(nibName:"BannerCell", bundle: nil), forCellWithReuseIdentifier: "banner")
    }
    
    ///Set gradient color to background
    private func setGradientBackground(colorTop: CGColor, colorBottom: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.bottomView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    ///Add BottomView to background
    private func addBottomView() {
        view.insertSubview(bottomView, at: 0)
        bottomView.isHidden = true
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.05).cgColor
        setGradientBackground(colorTop: colorTop, colorBottom: colorBottom)
    }
}
