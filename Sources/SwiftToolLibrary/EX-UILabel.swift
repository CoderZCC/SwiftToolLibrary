//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import UIKit

extension UILabel: EXCompatible { }
extension EX where T == UILabel {
    
    /// 已知文字内容计算文字宽度
    var textWidth: CGFloat? {
        return self.value.text?.ex.boundingWidth(16, self.value.font)
    }
    
    /// 设置文字行高
    /// - Parameters:
    ///   - text: 文字
    ///   - lineHeight: 行高
    func set(_ text: String?, lineHeight: CGFloat) {
        guard let text = text else {
            self.value.text = nil
            self.value.attributedText = nil
            return
        }
        self.value.numberOfLines = 0
        let realyFont: UIFont = self.value.font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        let baseLineOffset = (lineHeight - realyFont.lineHeight) / 4.0
        self.value.attributedText = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .baselineOffset: baseLineOffset, .font: realyFont, .foregroundColor: self.value.textColor ?? UIColor.black])
    }
    
    /// 设置文字行间距
    /// - Parameters:
    ///   - text: text
    ///   - lineSpacing: lineSpacing
    func set(_ text: String?, lineSpacing: CGFloat) {
        guard let text = text else {
            self.value.text = nil
            self.value.attributedText = nil
            return
        }
        self.value.numberOfLines = 0
        let realyFont: UIFont = self.value.font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        self.value.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font: realyFont, .foregroundColor: self.value.textColor ?? UIColor.black])
    }
}
