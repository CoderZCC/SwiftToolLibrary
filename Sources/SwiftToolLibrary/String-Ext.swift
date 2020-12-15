//
//  String-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/4.
//  Copyright © 2020 rubbish. All rights reserved.
//
import UIKit

public extension String {
    
    /// 获取Nib文件路径
    var nibPath: String? {
        return Bundle.main.path(forResource: self, ofType: "nib")
    }
    
    /// 创建Nib文件
    var nib: UINib? {
        return UINib.init(nibName: self, bundle: nil)
    }
    
    /// 图片
    var image: UIImage? {
        return UIImage(named: self)
    }
    
    /// 获取GBK编码字节数 中文-2个 英文-1个
    var byteCount: Int {
        var allCount: Int = 0
        for (_, value) in self.enumerated() {
            if value >= "\u{4E00}" && value <= "\u{9FA5}" {
                allCount += 2
            } else {
                allCount += 1
            }
        }
        return allCount
    }
    
    /// 转为颜色
    var toColor: UIColor? {
        guard self.count == 7 else { return nil }
        let num = Int(UInt(self.replacingOccurrences(of: "#", with: ""), radix: 16) ?? 0)
        let r = CGFloat((num & 0xFF0000) >> 16)
        let g = CGFloat((num & 0x00FF00) >> 8)
        let b = CGFloat((num & 0x0000FF))
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    /// 裁剪字符串
    /// - Parameters:
    ///   - from: 开始位置 从0开始
    ///   - to: 结束位置 不包含这个位置
    /// - Returns: String
    mutating func sub(from: Int = 0, to: Int) {
        if from > to { return }
        let startIndex = self.startIndex
        let fromIndex = self.index(startIndex, offsetBy: max(min(from, self.count), 0))
        let toIndex = self.index(startIndex, offsetBy: min(max(0, to), self.count))
        self = String(self[fromIndex ..< toIndex])
    }
    
    /// 裁剪按字节 一个汉字占两个 一个字母占一个
    /// - Parameter maxByte: 最大字节
    mutating func subByByte(to maxByte: Int) {
        var newStr: String = ""
        var allByte: Int = 0
        var textArr: [String] = []
        for c in self {
            textArr.append(String(c))
        }
        for (index, text) in textArr.enumerated() {
            let currentByte = text.byteCount
            allByte += currentByte
            newStr += text
            if allByte >= maxByte {
                break
            }
            if let nextByte = textArr[safe: index + 1]?.byteCount, allByte + nextByte > maxByte {
                // 现在的加上下一个超过限制了,取前一个防止越界
                break
            }
        }
        self = newStr
    }
    
    /// 是否符合密码规则
    var isPassword: Bool {
        let psd = "^\\S{6,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", psd)
        return predicate.evaluate(with: self)
    }
    /// 是否符合数字规则
    var isNumer: Bool {
        let psd = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", psd)
        return predicate.evaluate(with: self)
    }
    
    /// 计算文字宽度
    ///
    /// - Parameters:
    ///   - height: 高度
    ///   - font: 字体
    /// - Returns: 宽度
    func boundingTextWidth(height: CGFloat, font: UIFont?) -> CGFloat {
        let label = UILabel()
        label.frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(Int.max), height: height)
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.width
    }
    
    /// 计算文字高度
    ///
    /// - Parameters:
    ///   - width: 最大宽度
    ///   - lineHeight: 行高
    ///   - font: 字体大小
    /// - Returns: 高度
    func boundingTextHeight(width: CGFloat, lineHeight: CGFloat, font: UIFont?) -> CGFloat {
        if self.isBlank { return 0.0 }
        let realyFont: UIFont = font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        let baseLineOffset = (lineHeight - realyFont.lineHeight) / 4.0
        return NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(Int.max)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .baselineOffset: baseLineOffset, .font: realyFont], context: nil).size.height
    }
    
    /// 是否为空, 全空格/empty
    ///
    /// - Returns: 是否
    var isBlank: Bool {
        if self.isEmpty {
            return true
        }
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    //MARK: 替换指定区域的文字
    /// 替换指定区域的文字
    /// - Parameters:
    ///   - range: 需要替换的文字范围
    ///   - newStr: 替换的文字
    /// - Returns: 新字符串
    func replace(range: NSRange, with newStr: String) -> String {
        var newStr: String = self
        if let range = Range(range, in: self) {
            newStr.replaceSubrange(range, with: newStr)
        } else {
            fatalError("范围不正确")
        }
        return newStr
    }
}
