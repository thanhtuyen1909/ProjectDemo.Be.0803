//
//  ViewController.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreView: UIView!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    //@IBOutlet weak var bottomView: UIView!
    
    private var loader: DataLoader? = MockDataLoader()
    private var source = [CellController]()
    private var primary_text_color_dark = "#081F42"
    private var primary_text_color_light = "#FFFFFF"
    
    //private var primary_background_color_dark = "#001768"
    private var primary_background_color_light = "#FFC500"
    
    private var startY = 0.0
    
    private var name = "Thanh Tuyền"
    private var score = "12345"
    
    lazy var bottomView: UIView = {
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
        setupCollectionView()
        loadData()
        setTopView()
        view.backgroundColor = UIColor(hex: primary_background_color_light)
        view.insertSubview(bottomView, at: 0)
        bottomView.isHidden = true
        setGradientBackground()
    }
    
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
                //self?.setColorLabel(color: data.text_color)
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
        if source[indexPath.section].type == "grid" && indexPath.row == 0 {
            setBottomView(y: Double(cell.frame.origin.y + 108), height: view.frame.height - cell.frame.origin.y)
            self.startY = Double(cell.frame.origin.y + 108)
        }
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        recursiveSetTextColorForLabelsInView(inView: cell)
    //    }
    //
    //    func recursiveSetTextColorForLabelsInView(inView: UIView) {
    //        for view in inView.subviews {
    //            if let subview = view as? UILabel {
    //                subview.textColor = hexStringToUIColor(hex: text_color)
    //            }
    //            else {
    //                self.recursiveSetTextColorForLabelsInView(inView: view)
    //            }
    //        }
    //    }
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y / 120
        let y = view.frame.height - (startY - scrollView.contentOffset.y)
        let h = view.frame.height - y
        
//        let statusBar1 =  UIView()
//        statusBar1.frame = UIApplication.shared.statusBarFrame
        
//        print(scrollView.contentOffset.y)
        
        if offset > 1.2 {
            topView.backgroundColor = .white
            lineView.isHidden = false
            setColorLabel(color: primary_text_color_dark)
//            if #available(iOS 13.0, *) {
//                statusBar1.backgroundColor = UIColor(hex: primary_text_color_light)
//            }
            //setBottomView(y: bottomView.frame.origin.y - scrollView.contentOffset.y, height: view.frame.height - (bottomView.frame.origin.y - scrollView.contentOffset.y))
        } else {
            topView.backgroundColor = .clear
            lineView.isHidden = true
            setColorLabel(color: primary_text_color_light)
//            if #available(iOS 13.0, *) {
//                statusBar1.backgroundColor = UIColor(hex: primary_background_color_light)
//            }
            
        }
        setBottomView(y: h, height: y)
//        UIApplication.shared.keyWindow?.addSubview(statusBar1)
    }
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = CGFloat(0)
        var ratio = 0.0
        if source[indexPath.section].type == "grid" {
            if indexPath.row < 2 {
                width = (view.frame.width / 2) - 10
            }
            else {
                width = (view.frame.width / 4) - 15
            }
            ratio = (160 / 64)
            return CGSize(width: width, height: Double((view.frame.width / 2) - 10) / ratio)
        }
        if source[indexPath.section].type == "trip" {
            width = view.frame.width - 40
            ratio = (328 / 160)
            return CGSize(width: width, height: width / ratio)
        }
        width = view.frame.width - 40
        ratio = (336 / 96)
        return CGSize(width: width, height: width / ratio)
    }
}

extension DataViewController {
    func setBottomView(y: Double, height: Double) {
        bottomView.frame = CGRect(x: view.frame.origin.x, y: y, width: view.frame.width, height: height)
        
        if bottomView.isHidden == true {
            bottomView.isHidden = false
        }
    }
    
    func setBackgroundView(bg: String) {
        let image = UIImageView(frame: view.frame)
        image.contentMode = .scaleAspectFill
        image.load(urlString: bg)
        view.insertSubview(image, at: 0)
    }
    
    func setColorLabel(color: String) {
        userNameLabel.textColor = UIColor(hex: color)
        userScoreLabel.textColor = UIColor(hex: color)
    }
    
    func setTopView() {
        lineView.isHidden = true
        
        userScoreView.clipsToBounds = true
        userScoreView.layer.cornerRadius = 18
        
        userScoreLabel.text = score
        userNameLabel.text = "Chào \(name)!"
        userNameLabel.textColor = UIColor(hex: primary_text_color_light)
        userScoreLabel.textColor = UIColor(hex: primary_text_color_light)
        
        let heightStatusBar = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        topView.frame.size.height = 80 - heightStatusBar
        
        
    }
    
    func setupCollectionView() {
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
    
    func setGradientBackground() {
        let colorTop =  UIColor.white.cgColor
        let colorBottom = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.05).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.bottomView.layer.insertSublayer(gradientLayer, at:0)
    }
}
