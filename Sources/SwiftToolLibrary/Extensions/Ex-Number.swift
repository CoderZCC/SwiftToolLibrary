//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

extension Int: EXCompatible { }
public extension EX where T == Int {
    
    /// 16进制数字 转 颜色
    var color: UIColor? {
        let r = CGFloat((self.value & 0xFF0000) >> 16)
        let g = CGFloat((self.value & 0x00FF00) >> 8)
        let b = CGFloat((self.value & 0x0000FF))
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    /// 16进制数字 转 颜色
    var cgColor: CGColor? {
        self.color?.cgColor
    }
}

public extension EX where T == Int {

    /// 转为Double
    var doubleValue: Double {
        Double(self.value)
    }
    
    /// 转为CGFloat
    var floatVlaue: CGFloat {
        CGFloat(self.value)
    }
    
    /// 转为字符串
    /// - Parameter formart: 保留2位小数
    /// - Returns: str
    func strValue(_ formart: String = "%.2f") -> String {
        String(format: formart, self.value)
    }
}

extension CGFloat: EXCompatible { }
public extension EX where T == CGFloat {
    
    /// 转为字符串
    /// - Parameter formart: 保留2位小数
    /// - Returns: str
    func strValue(_ formart: String = "%.2f") -> String {
        String(format: formart, self.value)
    }
}

extension Double: EXCompatible { }
public extension EX where T == Double {
    
    /// 转为字符串
    /// - Parameter formart: 保留2位小数
    /// - Returns: str
    func strValue(_ formart: String = "%.2f") -> String {
        String(format: formart, self.value)
    }
}

public extension EX where T == String {
    
    /// intValue
    var intValue: Int? {
        Int(self.value)
    }
    
    /// doubleValue
    var doubleValue: Double? {
        Double(self.value)
    }
    
    /// doubleValue
    var floatValue: CGFloat? {
        if let d = self.doubleValue {
            return CGFloat(d)
        }
        return nil
    }
}
