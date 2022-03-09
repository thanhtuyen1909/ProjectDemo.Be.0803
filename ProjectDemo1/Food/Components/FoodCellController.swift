//
//  FoodCellController.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 09/03/2022.
//

import Foundation
import UIKit

class FoodCellController {
    let food: Food
    private var cell: FoodTVC?
    
    init(food: Food) {
        self.food = food
    }
    
    func cell(for tableView: UITableView, identifier: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodTVC else {
            return UITableViewCell()
        }
        self.cell = cell
        return cell
    }
    
    func display() {
        cell?.foodName.text = food.name
        cell?.foodAddress.text = food.address
    }
    
    func endDisplay() {
        cell = nil
    }
}
