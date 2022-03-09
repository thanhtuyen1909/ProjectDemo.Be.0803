//
//  ViewController.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 07/03/2022.
//

import UIKit

struct Food {
    let name: String?
    let address: String?
}

struct GroupFood {
    let name: String?
    let food: [Food]
}

class ViewController: UIViewController {
    
    let groupFoods = [
        GroupFood(name: "Trending", food: [
            Food(name: "Good Thai", address: "20 Queen Street, NSW"),
            Food(name: "Sushi Car", address: "20/25/26/27 Queen Street, NSW"),
            Food(name: "Blacksmith Cafe", address: "20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW"),
            Food(name: "Pizza Box", address: "20 Queen Street, NSW")
        ]),
        GroupFood(name: "Best sales", food: [
            Food(name: "Good Thai", address: "20 Queen Street, NSW"),
            Food(name: "Sushi Car", address: "20/25/26/27 Queen Street, NSW"),
            Food(name: "Blacksmith Cafe", address: "20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW"),
            Food(name: "Pizza Box", address: "20 Queen Street, NSW"),
            Food(name: "KFC", address: "Tran Hung Dao Street, ASA"),
            Food(name: "Pizza HUT", address: "20 Queen Street, KND"),
            
        ])]
    
    
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var bg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        foodTableView.estimatedRowHeight = 140
        foodTableView.rowHeight = UITableView.automaticDimension
        foodTableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "itemFood")
        
        foodTableView.dataSource = self
        foodTableView.delegate = self
        
        foodTableView.sectionHeaderTopPadding = 0
        //foodTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        // Make tv show
        foodTableView.separatorStyle = .none
        foodTableView.showsVerticalScrollIndicator = false
        
        //        // Make header
        //        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        //        header.backgroundColor = UIColor(patternImage: UIImage(named: "iStock-1131794876.t5d482e40.m800.xtDADj9SvTVFjzuNeGuNUUGY4tm5d6UGU5tkKM0s3iPk-620x342.jpg")!)
        //
        //        foodTableView.tableHeaderView = header
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = Bundle.main.loadNibNamed("SectionHeader", owner: self, options:nil)?.first as! SectionHeader
        headerCell.title.text = groupFoods[section].name
        headerCell.countFood.text = String(groupFoods[section].food.count) + " restaurants"
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupFoods.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupFoods[section].food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = foodTableView.dequeueReusableCell(withIdentifier: "itemFood") as? FoodTVC {
            let foodName = groupFoods[indexPath.section].food[indexPath.row] as Food
            cell.foodName.text = foodName.name
            cell.foodAddress.text = foodName.address
            return cell
        }
        return UITableViewCell()
    }
    
}

