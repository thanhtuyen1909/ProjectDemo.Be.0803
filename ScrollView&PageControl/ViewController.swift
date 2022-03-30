//
//  ViewController.swift
//  ScrollView&PageControl
//
//  Created by tuyen.quach on 28/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        cofigureScrollView()
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    func cofigureScrollView() {
        
        let colors: [UIColor] = [
            .red,
            .blue,
            .magenta,
            .brown
        ]
        
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(colors.count), height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        pageControl.numberOfPages = colors.count
        
        for x in 0..<colors.count {
            let page = UIView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.backgroundColor = colors[x]
            print(x)
            scrollView.addSubview(page)
        }
    }
    
}

