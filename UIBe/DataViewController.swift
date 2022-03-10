//
//  ViewController.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var loader: DataLoader? = MockDataLoader()
    private var datas = [DataCellController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionView()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemYellow
        
        collectionView.register(UINib(nibName:"TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        collectionView.register(UINib(nibName:"InputLocationCell", bundle: nil), forCellWithReuseIdentifier: "InputLocationCell")
        collectionView.register(UINib(nibName:"ServiceCell1", bundle: nil), forCellWithReuseIdentifier: "ServiceCell1")
        collectionView.register(UINib(nibName:"ServiceCell2", bundle: nil), forCellWithReuseIdentifier: "ServiceCell2")
    }
    
    func setupCellAndRegistrations() {
        
    }
    
    private func loadData() {
        loader?.loadData(completion: {data in
            self.datas = data.map({data1 in
                DataCellController(numberSection: data1.numberSection, banner: data1.banner.map({
                    banner in BannerCellController(type: banner.type, username: banner.username, userScore: banner.userScore, imgBanner: banner.imgBanner)
                }), location: data1.location.map({ location in LocationCellController(type: location.type)
                }), service: data1.service.map({
                    service in ServiceCellController(type: service.type, img: service.img, name: service.name)
                }))
            })
            self.collectionView.reloadData()
        })
    }
    
    private func loadImage(image_url: String, imageView: UIImageView){
        let url = URL(string: image_url)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
    }
}

extension DataViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas[0].numberSection!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return datas[0].banner.count
        case 1: return datas[0].location.count
        case 2: return datas[0].service.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: datas[0].banner[indexPath.row].type ?? "", for: indexPath) as! TitleCell
            
            cell.userLabel.text = "Chào " + datas[0].banner[indexPath.row].username! + " !"
            cell.userScoreLabel.text = String(datas[0].banner[indexPath.row].userScore!)
            loadImage(image_url: datas[0].banner[indexPath.row].imgBanner!, imageView: cell.bannerImageView)
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: datas[0].location[indexPath.row].type ?? "", for: indexPath) as! InputLocationCell
            
            return cell
        }
        
        if datas[0].service[indexPath.row].type == "ServiceCell1" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: datas[0].service[indexPath.row].type ?? "", for: indexPath) as! ServiceCell1
            cell.serviceLabel.text = datas[0].service[indexPath.row].name
            loadImage(image_url: datas[0].service[indexPath.row].img!, imageView: cell.serviceImageView)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: datas[0].service[indexPath.row].type ?? "", for: indexPath) as! ServiceCell2
        cell.serviceLabel.text = datas[0].service[indexPath.row].name
        loadImage(image_url: datas[0].service[indexPath.row].img!, imageView: cell.serviceImageView)
        
        return cell
    }
    
    //    private func serviceController(at indexPath: IndexPath) -> ServiceCellController {
    //        datas[indexPath.section].service[indexPath.row]
    //    }
    //
    //    private func dataCellController(at section: Int) -> DataCellController {
    //        datas[section]
    //    }
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2 {
            if datas[0].service[indexPath.row].type == "ServiceCell1" {
                return CGSize(width: (view.frame.width / 2) - 10, height: 60)
            }
            return CGSize(width: (view.frame.width / 4) - 10, height: 80)
        }
        if indexPath.section == 1 {
            return CGSize(width: view.frame.width - 40, height: 100)
        }
        return CGSize(width: view.frame.width, height: 200)
    }
    
}

class DataCellController {
    
    let numberSection: Int?
    var banner = [BannerCellController]()
    var location = [LocationCellController]()
    var service = [ServiceCellController]()
    
    init(numberSection: Int?, banner: [BannerCellController], location: [LocationCellController], service: [ServiceCellController]) {
        self.numberSection = numberSection
        self.banner = banner
        self.location = location
        self.service = service
    }
    
    
    
    //    func headerSection(for tableView: UITableView, section: Int) -> UIView {
    //        let headerSection = Bundle.main.loadNibNamed("SectionHeader", owner: FoodListViewController.self, options:nil)?.first as! SectionHeader
    //        self.headerSection = headerSection
    //        return headerSection
    //    }
    //
    //    func display() {
    //        headerSection?.title.text = name
    //        headerSection?.countFood.text = String(controllers.count) + " restaurants"
    //    }
    //
    //    func endDisplay() {
    //        headerSection = nil
    //    }
}

class BannerCellController {
    
    let type: String?
    let username: String?
    let userScore: Int?
    let imgBanner: String?
    
    init(type: String?, username: String?, userScore: Int?, imgBanner: String?) {
        self.type = type
        self.username = username
        self.userScore = userScore
        self.imgBanner = imgBanner
    }
}

class LocationCellController {
    let type: String?
    
    init(type: String?) {
        self.type = type
    }
}

class ServiceCellController {
    
    let type: String?
    let img: String?
    let name: String?
    
    init(type: String?, img: String?, name: String?) {
        self.type = type
        self.img = img
        self.name = name
    }
}
