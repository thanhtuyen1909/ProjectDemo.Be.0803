//
//  ViewController.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class DataViewController: UIViewController {
    
    //MARK: properties
    private var loader: DataLoader? = RemoteDataLoader()
    private var source = [CellController]()
    
    private lazy var startY = 0.0
    
    lazy var primary_text_color_dark = "#081F42"
    lazy var primary_text_color_light = "#FFFFFF"
    
    private lazy var bottomView: UIView = {
        let bottomView = UIView(frame: .zero)
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        bottomView.backgroundColor = .white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    private lazy var topScreen: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var navBar: NavBar = {
        let nav = NavBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        return nav
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //setupCollectionView()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomView()
        loadData()
        initTopScreen()
        initCollectionView()
        setupCollectionView()
    }
    
    private func configTopScreenConstraints() {
        let height = (view.frame.width) / (360 / 80)
        let constraints = [
            topScreen.topAnchor.constraint(equalTo: view.topAnchor),
            topScreen.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topScreen.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            topScreen.heightAnchor.constraint(equalToConstant: height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configCollectionViewConstraints() {
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initTopScreen() {
        topScreen.addSubview(navBar)
        view.addSubview(topScreen)
        configTopScreenConstraints()
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.bottomAnchor.constraint(equalTo: topScreen.bottomAnchor),
            navBar.leftAnchor.constraint(equalTo: topScreen.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: topScreen.rightAnchor)
        ])
    }
    
    private func initCollectionView() {
        view.addSubview(collectionView)
        configCollectionViewConstraints()
    }
    
    //MARK: Load data from api parse to CellController and reloadData of collectionView
    private func loadData() {
        loader?.loadData(completion: { [weak self] data in
            self?.source = data.source.map({
                item in
                let type = ItemType(rawValue: item.type)
                switch type {
                case .native_banner:
                    return NativeBannerCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                case .trip:
                    return LocationCellController(type: item.type, data: item.data, meta_data: item.meta_data)
                case .grid:
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
        
        // set startY and setBottomView when cell is the first element of section 2
        if source[indexPath.section].type == ItemType.grid.rawValue && indexPath.row == 0 {
            let originInRootView = collectionView.convert(cell.frame.origin, to: self.view)
            setBottomView(y: Double(originInRootView.y) - 10)
            self.startY = Double(originInRootView.y) - 10
        }
        
        return cell
    }
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
    }
    
    //MARK: Scroll header change color, white bottom background will scale
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distanceBanner = (((view.frame.width - 40) / (336 / 96)) + 30)
        let offset = scrollView.contentOffset.y / distanceBanner
        let y = startY - scrollView.contentOffset.y
        
        if offset > 1 {
            topScreen.backgroundColor = .white
            navBar.setupNavBarMode(style: .dark)
        } else {
            topScreen.backgroundColor = .clear
            navBar.setupNavBarMode(style: .light)
        }
        setBottomView(y: y)
    }
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return source[indexPath.section].sizeForItemAt(view: view, sizeForItemAt: indexPath)
    }
}

extension DataViewController {
    
    //MARK: Set frame to bottomView in background
    private func setBottomView(y: Double) {
        bottomView.frame = CGRect(x: view.frame.origin.x, y: y, width: view.frame.width, height: view.frame.height)
        
        if bottomView.isHidden{
            bottomView.isHidden = false
        }
    }
    
    //MARK: Set up background view
    private func setBackgroundView(bg: String) {
        let image = UIImageView(frame: view.frame)
        image.contentMode = .scaleAspectFill
        image.load(urlString: bg)
        view.insertSubview(image, at: 0)
    }

    //MARK: Set up collectionView and register cell in collectionView
    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(UINib(nibName:"NativeBannerCell", bundle: nil), forCellWithReuseIdentifier: NativeBannerCell().identifier)
        collectionView.register(UINib(nibName:"InputLocationCell", bundle: nil), forCellWithReuseIdentifier: InputLocationCell().identifier)
        collectionView.register(UINib(nibName:"PromoteServiceCell", bundle: nil), forCellWithReuseIdentifier: PromoteServiceCell().identifier)
        collectionView.register(UINib(nibName:"NormalServiceCell", bundle: nil), forCellWithReuseIdentifier: NormalServiceCell().identifier)
        collectionView.register(UINib(nibName:"BannerCell", bundle: nil), forCellWithReuseIdentifier: BannerCell().identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Set gradient color to background
    private func setGradientBackground(colorTop: CGColor, colorBottom: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.bottomView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    //MARK: Add BottomView to background
    private func addBottomView() {
        view.insertSubview(bottomView, at: 0)
        bottomView.isHidden = true
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.05).cgColor
        setGradientBackground(colorTop: colorTop, colorBottom: colorBottom)
    }
}
