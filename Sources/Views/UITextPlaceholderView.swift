//
//  UITextPlaceholderView.swift
//  SwiftToolLibrary
//
//  Created by CC Z on 2021/7/9.
//

import UIKit

/// 带有展位文字的TextView
public class UITextPlaceholderView: UITextView {
    /// 最多文字数 英文-1 汉字-1
    public var maxTextLength: Int?
    /// 最大字节数 英文-1 汉字-2
    public var maxTextByte: Int?
    /// 占位文字
    public var placeholder: (String?)->Void {
        return { c in
            self._placeholder.text = c
        }
    }
    /// 占位文字颜色
    public var placeholderColor: (UIColor?)->Void {
        return { c in
            self._placeholder.textColor = c
        }
    }
    /// 文字间隔,在font设置之后
    public var lineSpacing: (CGFloat)->Void {
        return { spacing in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = spacing
            self.typingAttributes = [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.paragraphStyle: paragraphStyle]
            self._placeholder.typingAttributes = self.typingAttributes
        }
    }
    
    public override var textColor: UIColor? {
        willSet {
            self.tintColor = newValue
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self._updateTextView()
    }
    
    private lazy var _placeholder: UITextView = {
        let placeholderView = UITextView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        placeholderView.isUserInteractionEnabled = false
        placeholderView.isScrollEnabled = false
        self.insertSubview(placeholderView, at: 0)
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(_textChangeNoteEx), name: UITextView.textDidChangeNotification, object: nil)
        
        return placeholderView
    }()
    
    @objc private func _textChangeNoteEx(_ note: Notification) {
        guard let input = note.object as? UITextPlaceholderView else { return }
        let finalText = input.text ?? ""
        input._placeholder.isHidden = !finalText.isEmpty
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
    
    private func _updateTextView() {
        self._placeholder.frame = self.bounds
        self._placeholder.backgroundColor = self.backgroundColor
        self._placeholder.font = self.font
        self._placeholder.typingAttributes = self.typingAttributes
        let finalText = self.text ?? ""
        self._placeholder.isHidden = !finalText.isEmpty
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
