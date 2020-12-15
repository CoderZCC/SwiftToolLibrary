//
//  UITextFiled-Category.swift
//  HmmToCProject
//
//  Created by 北京摩学教育科技有限公司 on 2020/9/9.
//  Copyright © 2020 zcc. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /// 占位文字颜色, 请先设置 placeholder 占位文字
    var placeholderColor: (UIColor)->Void {
        return { c in
            if let p = self.placeholder {
                let att = NSAttributedString(string: p, attributes: [NSAttributedString.Key.foregroundColor : c])
                self.attributedPlaceholder = att
            } else {
                fatalError("请先设置 placeholder 占位文字")
            }
        }
    }
    
    /// 最多文字数 英文-1 汉字-1 仅一个有效
    var maxTextLength: (Int)->Void {
        return { count in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: OperationQueue.main) { (note) in
                let tf = note.object as? UITextField
                guard let input = tf?.text else { return }
                if input.count > count {
                    tf?.text?.sub(to: count)
                }
            }
        }
    }
    /// 最大字节数 英文-1 汉字-2 仅一个有效
    var maxTextByte: (Int)->Void {
        return { count in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: OperationQueue.main) { (note) in
                let tf = note.object as? UITextField
                guard let input = tf?.text else { return }
                if input.byteCount > count {
                    tf?.text?.subByByte(to: count)
                }
            }
        }
    }
}
