//
//  SectionCellController.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 09/03/2022.
//

import Foundation
import UIKit

class SectionCellController {
    
    let name: String?
    var controllers = [FoodCellController]()
    private var headerSection: SectionHeader?
    
    init(name: String?, controllers: [FoodCellController]) {
        self.name = name
        self.controllers = controllers
    }
    
    func headerSection(for tableView: UITableView, section: Int) -> UIView {
        let headerSection = Bundle.main.loadNibNamed("SectionHeader", owner: FoodListViewController.self, options:nil)?.first as! SectionHeader
        self.headerSection = headerSection
        return headerSection
    }
    
    func display() {
        headerSection?.title.text = name
        headerSection?.countFood.text = String(controllers.count) + " restaurants"
    }
    
    func endDisplay() {
        headerSection = nil
    }
}

// "QUan 1; quan 2"

fileprivate extension Array where Element == FoodCellController {
    func restaurantNames() -> String {
         var name = ""
        self.forEach {
            let foodName = $0.food.address ?? ""
            name = name.isEmpty ? foodName : "\(name); \(foodName)"
        }
        return name
    }
    
    func restaurantNames2() -> String {
        let a = reduce(into: "") { partialResult, value in
            let foodName = value.food.address ?? ""
            partialResult = partialResult.isEmpty ? foodName : "\(partialResult); \(foodName)"
        }
       return a
    }
}
