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
    
    private var loader: DataLoader? = MockDataLoader()
    private var source = [CellController]()
    private var primary_text_color_dark = "#081F42"
    private var primary_text_color_light = "#FFFFFF"
    
    //private var primary_background_color_dark = "#001768"
    private var primary_background_color_light = "#FFC500"
    
    private var name = "Thanh Tuyền"
    private var score = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        loadData()
        setTopView()
        view.backgroundColor = UIColor(hex: primary_background_color_light)
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
                case "banner":
                    return BannerCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                default:
                    return CellController(type: item.type, data: item.data, meta_data: item.meta_data)
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
                
                //self?.setBackgroundView(bg: data.background_image)
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
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y / 120
        
        let statusBar1 =  UIView()
        statusBar1.frame = UIApplication.shared.statusBarFrame
        
        if offset > 1.2 {
            topView.backgroundColor = .white
            lineView.isHidden = false
            userNameLabel.textColor = UIColor(hex: primary_text_color_dark)
            userScoreLabel.textColor = UIColor(hex: primary_text_color_dark)
            if #available(iOS 13.0, *) {
                statusBar1.backgroundColor = UIColor(hex: primary_text_color_light)
            }
        } else {
            topView.backgroundColor = .clear
            lineView.isHidden = true
            userNameLabel.textColor = UIColor(hex: primary_text_color_light)
            userScoreLabel.textColor = UIColor(hex: primary_text_color_light)
            if #available(iOS 13.0, *) {
                statusBar1.backgroundColor = UIColor(hex: primary_background_color_light)
            }
        }
        UIApplication.shared.keyWindow?.addSubview(statusBar1)
    }
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if source[indexPath.section].type == "grid" {
            if indexPath.row < 2 {
                return CGSize(width: (view.frame.width / 2) - 10, height: 65)
            }
            return CGSize(width: (view.frame.width / 4) - 15, height: 80)
        }
        if(source[indexPath.section].type == "trip") {
            return CGSize(width: view.frame.width - 40, height: 190)
        }
        return CGSize(width: view.frame.width - 40, height: 120)
        
        //        return CGSize(width: view.frame.width - 40, height: 200)
    }
}

extension UIColor {
    
    convenience init?(hex: String, alpha: CGFloat = 1) {
        self.init(hexa: UInt(hex.dropFirst(), radix: 16) ?? 0, alpha: alpha)
    }
    convenience init(hexa: UInt, alpha: CGFloat = 1) {
        self.init(red:   .init((hexa & 0xff0000) >> 16) / 255,
                  green: .init((hexa & 0xff00  ) >>  8) / 255,
                  blue:  .init( hexa & 0xff    )        / 255,
                  alpha: alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
