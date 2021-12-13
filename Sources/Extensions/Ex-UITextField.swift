//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

public extension EX where T: UITextField {
    
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
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: OperationQueue.main) { (_) in
                guard let input = self.value.text, self.value.markedTextRange == nil, input.count > count else { return }
                self.value.text = input.ex.sub(to: count)
            }
        }
    }
    /// 最大字节数 英文-1 汉字-2 仅一个有效
    var maxTextByte: (Int)->Void {
        return { count in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: OperationQueue.main) { (_) in
                guard let input = self.value.text, self.value.markedTextRange == nil, input.ex.byteCount > count else { return }
                self.value.text = input.ex.subByByte(to: count)
            }
        }
    }
}
