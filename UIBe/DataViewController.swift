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
    private var datas = [SectionController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
        loadData()
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
        loader?.loadData(completion: { data in
                self.datas = data.source.map({
                    item in SectionController(source: [item])
                    
            })
            self.collectionView.reloadData()
        })
        
    }
}

extension DataViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberItems = datas[section].numberOfItemsInSections()
        return numberItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = datas[indexPath.section].cellForItemAtIndex(for: collectionView, indexPath: indexPath)
        return cell
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
            if datas[indexPath.section].source[0][indexPath.row].type == "ServiceCell1" {
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
