//
//  FoodListViewController.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 07/03/2022.
//

import UIKit

class FoodListViewController: UIViewController {
    
    private var groupFoods = [SectionCellController]()
    
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var bg: UIImageView!
    
    private var loader: FoodLoader? = MockFoodLoader()
    private let foodCellIdentifier = "itemFood"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        foodTableView.estimatedRowHeight = 140
        foodTableView.rowHeight = UITableView.automaticDimension
        foodTableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: foodCellIdentifier)
        
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
        loadFood()
    }
    
    private func loadFood() {
        loader?.loadFood(completion: {groupFood in
            self.groupFoods = groupFood.map({group in
                SectionCellController(name: group.name ?? "", controllers: group.food.map( {
                    food in FoodCellController(food: food)
                }))
            })
            self.foodTableView.reloadData()
        })
    }
    
}


extension FoodListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionCellController(at: section).headerSection(for: tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        return sectionCellController(at: section).display()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        return sectionCellController(at: section).endDisplay()
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
        return groupFoods[section].controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(at: indexPath).cell(for: tableView, identifier: foodCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController(at: indexPath).display()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController(at: indexPath).endDisplay()
    }
    
    private func cellController(at indexPath: IndexPath) -> FoodCellController {
        groupFoods[indexPath.section].controllers[indexPath.row]
    }
    
    private func sectionCellController(at section: Int) -> SectionCellController {
        groupFoods[section]
    }
}
