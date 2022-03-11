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
        
        setupCollectionView()
        loadData()
        
        
        print([3, 2, 3, 4].sum())
    }
    
    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemYellow
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName:"TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        collectionView.register(UINib(nibName:"InputLocationCell", bundle: nil), forCellWithReuseIdentifier: "InputLocationCell")
        collectionView.register(UINib(nibName:"ServiceCell1", bundle: nil), forCellWithReuseIdentifier: "ServiceCell1")
        collectionView.register(UINib(nibName:"ServiceCell2", bundle: nil), forCellWithReuseIdentifier: "ServiceCell2")
    }
    
    private func loadData() {
        loader?.loadData(completion: {data in
            self.datas = data.map({data1 in
//                DataCellController[data1.banner.map({
//                    banner in BannerCellController(type: banner.type, username: banner.username, userScore: banner.userScore, imgBanner: banner.imgBanner)
//                })], [data1.location.map({ location in LocationCellController(type: location.type)
//                }), service: data1.service.map({
//                    service in ServiceCellController(type: service.type, img: service.img, name: service.name)
//                })])
                
                
//                DataCellController(source: [data1.source[0].map({
//                    banner in BannerCellController(type: banner.type, username: banner.username, userScore: banner.userScore, imgBanner: banner.imgBanner)
//                }), [], []])
                
                DataCellController(numberSection: data1.numberSection, banner: data1.banner.map({
                    banner in BannerCellController(type: banner.type, username: banner.username, userScore: banner.userScore, imgBanner: banner.imgBanner)
                }), location: data1.location.map({
                    location in LocationCellController(type: location.type)
                }), service: data1.service.map({
                    service in ServiceCellController(type: service.type, img: service.img, name: service.name)
                }))
            })
            self.collectionView.reloadData()
        })
    }
}

extension DataViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataCellController().numberSection!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberItems = dataCellController().dataNumberItemsOfSection(for: collectionView, section: section)
        return numberItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataCellController().dataCell(for: collectionView, indexPath: indexPath)
        return cell
    }
    
    private func dataCellController() -> DataCellController {
        datas[0]
    }
}

extension DataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2 {
            if datas[0].service[indexPath.row].type == "ServiceCell1" {
                return CGSize(width: (view.frame.width / 2) - 10, height: 60)
            }
            return CGSize(width: (view.frame.width / 4) - 15, height: 80)
        }
        if indexPath.section == 1 {
            return CGSize(width: view.frame.width - 40, height: 120)
        }
        return CGSize(width: view.frame.width - 40, height: 200)
    }
    
}




fileprivate extension Array where Element == Int {
    func sum() -> Int {
        var sum = 0
        for index in 0..<count {
            sum += index
            print("\(index)")
        }
        return sum
    }
}
