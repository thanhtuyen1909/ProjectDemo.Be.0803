//
//  GradientView.swift
//  UIBe
//
//  Created by tuyen.quach on 13/04/2022.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientBackground()
    }
    
    //MARK: Set gradient color to background
    private func setupGradientBackground() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.05).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
