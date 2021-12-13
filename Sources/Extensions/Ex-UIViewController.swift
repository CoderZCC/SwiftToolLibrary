//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

class KeyboardObj {
    static let `default` = KeyboardObj()
    weak var view: UIView?
    
    class _TapDismissKbGesture: UITapGestureRecognizer { }
    
    /// 点击消失键盘
    func tapDismissKeyboard() {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let self = self, let view = self.view else { return }
            if !(view.gestureRecognizers?.contains(where: { $0 is _TapDismissKbGesture }) ?? false) {
                view.addGestureRecognizer(self._tapGesture)
            }
        }
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let self = self, let view = self.view else { return }
            view.gestureRecognizers?.removeAll(where: { $0 is _TapDismissKbGesture })
        }
    }
    
    lazy var _tapGesture: UITapGestureRecognizer = {
        _TapDismissKbGesture(target: self, action: #selector(self._tapAction))
    }()
    
    @objc private func _tapAction() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

extension UIViewController: EXCompatible { }
public extension EX where T: UIViewController {
        
    /// 点击消失键盘
    func tapDismissKeyboard() {
        let tool = KeyboardObj.default
        tool.view = self.value.view
        tool.tapDismissKeyboard()
    }
}
