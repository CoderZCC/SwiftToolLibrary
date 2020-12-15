//
//  UIColor-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/7.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension Int {
    
    var color: UIColor? {
        let r = CGFloat((self & 0xFF0000) >> 16)
        let g = CGFloat((self & 0x00FF00) >> 8)
        let b = CGFloat((self & 0x0000FF))
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    var cgColor: CGColor? {
        return self.color?.cgColor
    }
}

public extension UIColor {
    
    /// 随机色
    static var random: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public extension Int {
    
    /// 时间戳格式化
    /// - Parameter formatter: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: string
    func formatter(_ formatter: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let text = "\(self)"
        if text.count < 10 || text.count > 13 { return nil }
        var newValue: TimeInterval!
        if text.count == 13 {
            newValue = TimeInterval(self / 1000)
        } else {
            newValue = TimeInterval(self)
        }
        var date = Date(timeIntervalSince1970: newValue)
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        date.addTimeInterval(TimeInterval(interval))
        
        let dateF: DateFormatter = DateFormatter()
        dateF.timeZone = TimeZone(abbreviation: "UTC")
        dateF.dateFormat = formatter
        return dateF.string(from: date)
    }
}
