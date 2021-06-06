//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

public extension UITextView {

    /// 最多文字数 英文-1 汉字-1
    var maxTextLength: Int? {
        set {
            k_setAssociatedObject(key: "maxTextLength", value: newValue)
        }
        get {
            k_getAssociatedObject(key: "maxTextLength") as? Int
        }
    }
    /// 最大字节数 英文-1 汉字-2
    var maxTextByte: Int? {
        set {
            k_setAssociatedObject(key: "maxTextByte", value: newValue)
        }
        get {
            k_getAssociatedObject(key: "maxTextByte") as? Int
        }
    }
    /// 占位文字
    var placeholder: (String?)->Void {
        return { c in
            self._placeholderView.text = c
        }
    }
    /// 占位文字颜色
    var placeholderColor: (UIColor?)->Void {
        return { c in
            self._placeholderView.textColor = c
        }
    }
    /// 文字间隔,在font设置之后
    var lineSpacing: (CGFloat)->Void {
        return { spacing in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = spacing
            self.typingAttributes = [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.paragraphStyle: paragraphStyle]
            self._placeholderView.typingAttributes = self.typingAttributes
        }
    }
    
    override var frame: CGRect {
        didSet {
            self._placeholderView.frame = CGRect(origin: .zero, size: self.frame.size)
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self._placeholderView.backgroundColor = self.backgroundColor
        }
    }
}

private extension UITextView {
    
    static let keyEx: String = "UITextViewPlaceholderkeyEx"
    var _placeholderView: UITextView {
        if let p = k_getAssociatedObject(key: UITextView.keyEx) as? UITextView {
            return p
        }
        let placeholderView = UITextView(frame: self.bounds)
        placeholderView.isUserInteractionEnabled = false
        self.insertSubview(placeholderView, at: 0)
        k_setAssociatedObject(key: UITextView.keyEx, value: placeholderView)
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(_textChangeNoteEx), name: UITextView.textDidChangeNotification, object: nil)
        return placeholderView
    }
    
    @objc func _textChangeNoteEx(_ note: Notification) {
        guard let input = note.object as? UITextView else { return }
        let finalText = input.text ?? ""
        input._placeholderView.isHidden = !finalText.isEmpty
        if let count = self.maxTextLength {
            if finalText.count > count {
                input.text = finalText.ex.sub(to: count)
            }
        } else if let count = self.maxTextByte {
            if finalText.ex.byteCount > count {
                input.text = finalText.ex.subByByte(to: count)
            }
        }
    }
}
