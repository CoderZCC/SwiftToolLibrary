//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
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
        return self.color?.cgColor
    }
}
