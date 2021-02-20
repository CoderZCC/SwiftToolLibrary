//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension Int: EXCompatible { }
extension EX where T == Int {
    
    /// 16进制数字 转 颜色
    var color: UIColor? {
        let r = CGFloat((self.value & 0xFF0000) >> 16)
        let g = CGFloat((self.value & 0x00FF00) >> 8)
        let b = CGFloat((self.value & 0x0000FF))
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    /// 16进制数字 转 颜色
    var cgColor: CGColor? {
        return self.color?.cgColor
    }
    
    /// 时间戳格式化
    /// - Parameter format: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: (Date, String)?
    func dateFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> (Date, String)? {
        let text = "\(self.value)"
        if text.count < 10 || text.count > 13 { return nil }
        var newValue: TimeInterval!
        if text.count == 13 {
            newValue = TimeInterval(self.value / 1000)
        } else {
            newValue = TimeInterval(self.value)
        }
        var date = Date(timeIntervalSince1970: newValue)
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        date.addTimeInterval(TimeInterval(interval))
        
        let dateF: DateFormatter = DateFormatter()
        dateF.timeZone = TimeZone(abbreviation: "UTC")
        dateF.dateFormat = format
        return (date, dateF.string(from: date))
    }
}
