//
//  MusicTable.swift
//  iTunesBasicSearchAPI
//
//  Created by tuyen.quach on 23/03/2022.
//

import UIKit

class MusicTable: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var arrMusic = [Music]() {
        didSet {
            reloadData()
        }
    }
    
    override class func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMusic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}
