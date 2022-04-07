//
//  UIColor.swift
//  UIBe
//
//  Created by tuyen.quach on 07/04/2022.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String, alpha: CGFloat = 1) {
        self.init(hexa: UInt(hex.dropFirst(), radix: 16) ?? 0, alpha: alpha)
    }
    convenience init(hexa: UInt, alpha: CGFloat = 1) {
        self.init(red:   .init((hexa & 0xff0000) >> 16) / 255,
                  green: .init((hexa & 0xff00  ) >>  8) / 255,
                  blue:  .init( hexa & 0xff    )        / 255,
                  alpha: alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
