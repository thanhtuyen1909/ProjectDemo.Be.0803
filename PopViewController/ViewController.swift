//
//  ViewController.swift
//  PopViewController
//
//  Created by tuyen.quach on 30/03/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
//
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.addSubview(webView)
        
//        guard let url = URL(string: "https://developer.apple.com") else {
//            return
//        }
//
//        webView.load(URLRequest(url: url))
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        webView.frame = view.bounds
//    }

    @IBAction func showSplitView(_ sender: UIButton) {
        let splitVC = UISplitViewController(style: .doubleColumn)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .systemRed 
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: MenuController(style: .plain)),
            UINavigationController(rootViewController: secondVC)
        ]
        
        present(splitVC, animated: true)
    }
    

}

class MenuController : UITableViewController {
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    required init?(coder: NSCoder) {
        fatalError("error: has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test \(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
