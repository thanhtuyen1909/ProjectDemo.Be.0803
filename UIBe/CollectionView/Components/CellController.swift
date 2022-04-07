//
//  CellController.swift
//  UIBe
//
//  Created by tuyen.quach on 16/03/2022.
//
import UIKit

protocol CellController {
    
    var type: String { get set }
    var data: [HomeSessionService] { get set }
    var meta_data: [String: Any] { get set }
    
    init(type: String, data: [HomeSessionService], meta_data: [String: Any])
    
    func cellForItemAtIndex(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
   
    func numberOfItemsInSections() -> Int
    
}

