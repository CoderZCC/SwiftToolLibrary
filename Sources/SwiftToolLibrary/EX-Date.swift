//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import Foundation

public extension EX where T == Int {
    
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

public extension EX where T == String {
    
    /// 时间格式化
    /// - Parameter format: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: Date
    func dateFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateF = DateFormatter()
        dateF.timeZone = TimeZone(abbreviation: "UTC")
        dateF.dateFormat = format
        return dateF.date(from: self.value)
    }
}

extension Date: EXCompatible { }
public extension EX where T == Date {
    
    /// 时间格式化
    /// - Parameter format: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: String
    func dateFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        var date = self.value
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        date.addTimeInterval(TimeInterval(interval))
        
        let dateF = DateFormatter()
        dateF.timeZone = TimeZone(abbreviation: "UTC")
        dateF.dateFormat = format
        return dateF.string(from: date)
    }
}
