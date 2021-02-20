//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import UIKit

extension UITextField: EXCompatible { }
extension EX where T == UITextField {
    
    /// 占位文字颜色, 请先设置 placeholder 占位文字
    var placeholderColor: (UIColor)->Void {
        return { c in
            if let p = self.value.placeholder {
                let att = NSAttributedString(string: p, attributes: [NSAttributedString.Key.foregroundColor : c])
                self.value.attributedPlaceholder = att
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
                    tf?.text = tf?.text?.ex.sub(to: count)
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
                if input.ex.byteCount > count {
                    tf?.text = tf?.text?.ex.subByByte(to: count)
                }
            }
        }
    }
}
