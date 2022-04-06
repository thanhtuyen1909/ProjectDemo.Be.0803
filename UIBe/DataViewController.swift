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
    
    private var loader: DataLoader? = MockDataLoader()
    private var source = [CellController]()
    private var background_image = ""
    private var text_color = ""
    private var name = "Thanh Tuyền"
    private var score = "12345"
    //private var titleView = TitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        loadData()
        setTopView()
    }
    
    func setTopView() {
        userScoreView.clipsToBounds = true
        userScoreView.layer.cornerRadius = 18
        
        userScoreLabel.text = score
        userNameLabel.text = "Chào \(name)!"
    }

    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName:"NativeBannerCell", bundle: nil), forCellWithReuseIdentifier: "native_banner")
        collectionView.register(UINib(nibName:"InputLocationCell", bundle: nil), forCellWithReuseIdentifier: "trip")
        collectionView.register(UINib(nibName:"ServiceCell1", bundle: nil), forCellWithReuseIdentifier: "ServiceCell1")
        collectionView.register(UINib(nibName:"ServiceCell2", bundle: nil), forCellWithReuseIdentifier: "ServiceCell2")
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
                self?.background_image = data.background_image
                self?.text_color = data.text_color
                
                guard let frame = self?.view.frame else {
                    return
                }
                
                let image = UIImageView(frame: frame)
                image.contentMode = .scaleAspectFill
                image.load(urlString: self?.background_image ?? "")
                self?.view.insertSubview(image, at: 0)
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
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
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
        return CGSize(width: view.frame.width - 40, height: 120)
//        return CGSize(width: view.frame.width - 40, height: 200)
    }
    
}
