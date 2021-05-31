//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension String: EXCompatible { }
public extension EX where T == String {
    
    /// 是否为空, 全空格/empty
    ///
    /// - Returns: 是否
    var isBlank: Bool {
        if self.value.isEmpty {
            return true
        }
        return self.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
        
    /// 是否包含汉字
    var isContainHan: Bool {
        for i in self.value {
            if "\u{4E00}" <= i && i <= "\u{9FA5}" {
                return true
            }
        }
        return false
    }
    
    /// 是否符合密码规则 6-16位
    var isPassword: Bool {
        let psd = "^\\S{6,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", psd)
        return predicate.evaluate(with: self.value)
    }
    
    /// 是否全是数字
    var isNumer: Bool {
        let psd = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", psd)
        return predicate.evaluate(with: self.value)
    }
    
    /// json序列化为对象
    var anyObject: Any? {
        guard let jsonData = self.value.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
    }
    
    /// 获取字节数 中文-2个 英文-1个
    var byteCount: Int {
        var allCount: Int = 0
        for (_, value) in self.value.enumerated() {
            if value >= "\u{4E00}" && value <= "\u{9FA5}" {
                allCount += 2
            } else {
                allCount += 1
            }
        }
        return allCount
    }
    
    /// 裁剪字符串 按个数
    /// - Parameters:
    ///   - from: 开始位置 从0开始
    ///   - to: 结束位置 不包含这个位置
    /// - Returns: String
    func sub(from: Int = 0, to: Int) -> String {
        if from > to { return self.value }
        let startIndex = self.value.startIndex
        let fromIndex = self.value.index(startIndex, offsetBy: max(min(from, self.value.count), 0))
        let toIndex = self.value.index(startIndex, offsetBy: min(max(0, to), self.value.count))
        return String(self.value[fromIndex ..< toIndex])
    }
    
    /// 裁剪字符串 按字节(一个汉字占两个 一个字母占一个)
    /// - Parameter maxByte: 最大字节
    func subByByte(to maxByte: Int) -> String {
        var newStr: String = ""
        var allByte: Int = 0
        var textArr: [String] = []
        for c in self.value {
            textArr.append(String(c))
        }
        for (index, text) in textArr.enumerated() {
            let currentByte = text.ex.byteCount
            allByte += currentByte
            newStr += text
            if allByte >= maxByte { break }
            if let nextByte = textArr[safe: index + 1]?.ex.byteCount, allByte + nextByte > maxByte {
                // 现在的加上下一个超过限制了,取前一个防止越界
                break
            }
        }
        return newStr
    }
    
    /// 计算单行文字宽度
    /// - Parameters:
    ///   - height: 单行高度
    ///   - font: 字体
    /// - Returns: 宽度
    func boundingWidth(_ height: CGFloat, _ font: UIFont?) -> CGFloat {
        let label = UILabel()
        label.frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(Int.max), height: height)
        label.font = font
        label.text = self.value
        label.sizeToFit()
        return label.frame.width
    }
    
    /// 计算文字高度
    /// - Parameters:
    ///   - maxWidth: 最大宽度
    ///   - lineHeight: 单行行高
    ///   - font: 字体
    /// - Returns: 高度
    func boundingHeight(_ maxWidth: CGFloat, _ lineHeight: CGFloat, _ font: UIFont?) -> CGFloat {
        let realyFont: UIFont = font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        let baseLineOffset = (lineHeight - realyFont.lineHeight) / 4.0
        return NSString(string: self.value).boundingRect(with: CGSize(width: maxWidth, height: CGFloat(Int.max)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .baselineOffset: baseLineOffset, .font: realyFont], context: nil).size.height
    }
    
    /// 替换指定区域文字内容
    /// - Parameters:
    ///   - range: NSRange
    ///   - new: String
    /// - Returns: String
    func replace(_ range: NSRange, with new: String?) -> String {
        guard let new = new else { return self.value }
        var newStr: String = self.value
        if let range = Range(range, in: self.value) {
            newStr.replaceSubrange(range, with: new)
        } else {
            fatalError("范围不正确")
        }
        return newStr
    }
}
