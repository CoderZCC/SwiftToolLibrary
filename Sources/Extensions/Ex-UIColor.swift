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
    
    /// 初始化颜色
    /// - Parameter hexValue: Int
    convenience init(hexValue: Int) {
        let r = CGFloat((hexValue & 0xFF0000) >> 16)
        let g = CGFloat((hexValue & 0x00FF00) >> 8)
        let b = CGFloat((hexValue & 0x0000FF))
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    /// 初始化颜色
    /// - Parameter hexValue: String
    convenience init? (hexValue: String) {
        var cstr = hexValue.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if (cstr.length < 6) {
            return nil
        }
        if (cstr.hasPrefix("0X")) {
            cstr = cstr.substring(from: 2) as NSString
        }
        if (cstr.hasPrefix("#")) {
            cstr = cstr.substring(from: 1) as NSString
        }
        if (cstr.length != 6) {
            return nil
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range)
        //g
        range.location = 2
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4
        let bStr = cstr.substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rStr).scanHexInt32(&r)
        Scanner.init(string: gStr).scanHexInt32(&g)
        Scanner.init(string: bStr).scanHexInt32(&b)
        self.init(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
