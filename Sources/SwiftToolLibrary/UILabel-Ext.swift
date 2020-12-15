//
//  UILabel-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/7.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// 根据文字计算宽度
    var textWidth: CGFloat? {
        return self.text?.boundingTextWidth(height: 20.0, font: self.font)
    }
}

public extension UILabel {
    
    /// 设置文字
    /// - Parameters:
    ///   - text: 文字
    ///   - lineHeight: 行高
    func set(text: String?, lineHeight: CGFloat) {
        guard let text = text else {
            self.text = nil
            self.attributedText = nil
            return
        }
        self.numberOfLines = 0
        let realyFont: UIFont = self.font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        let baseLineOffset = (lineHeight - realyFont.lineHeight) / 4.0
        self.attributedText = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .baselineOffset: baseLineOffset, .font: realyFont, .foregroundColor: self.textColor ?? UIColor.black])
    }
    
    /// 设置行间距
    /// - Parameters:
    ///   - text: text
    ///   - lineSpacing: lineSpacing
    func set(_ text: String?, lineSpacing: CGFloat) {
        guard let text = text else {
            self.text = nil
            self.attributedText = nil
            return
        }
        self.numberOfLines = 0
        let realyFont: UIFont = self.font ?? UIFont.systemFont(ofSize: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font: realyFont, .foregroundColor: self.textColor ?? UIColor.black])
    }
}

