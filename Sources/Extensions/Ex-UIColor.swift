//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

public extension UIColor {
    /// 随机色
    static var random: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init(hexValue: Int) {
        let r = CGFloat((hexValue & 0xFF0000) >> 16)
        let g = CGFloat((hexValue & 0x00FF00) >> 8)
        let b = CGFloat((hexValue & 0x0000FF))
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    convenience init(hexValue: String) {
        self.init()
        
    }
}
