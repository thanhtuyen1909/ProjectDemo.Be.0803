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
    private var cell: SectionHeader?
    
    init(name: String?, controllers: [FoodCellController]) {
        self.name = name
        self.controllers = controllers
    }
    
    func cell(for tableView: UITableView, section: Int) -> UIView {
        let headerCell = Bundle.main.loadNibNamed("SectionHeader", owner: FoodListViewController.self, options:nil)?.first as! SectionHeader
        self.cell = headerCell
        return headerCell
    }
    
    func display() {
        cell?.title.text = name
        cell?.countFood.text = String(controllers.count) + " restaurants"
    }
    
    func endDisplay() {
        cell = nil
    }
}
