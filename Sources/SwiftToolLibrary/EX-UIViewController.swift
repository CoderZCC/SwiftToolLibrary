//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import UIKit

public extension UIViewController {
    
    class _TapDismissKbGesture: UITapGestureRecognizer { }
    
    /// 点击消失键盘
    func tapDismissKeyboard() {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            let tap = _TapDismissKbGesture(target: self, action: #selector(self?._tapAction))
            self?.view.addGestureRecognizer(tap)
        }
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            for g in self?.view.gestureRecognizers ?? [] where g is _TapDismissKbGesture {
                self?.view.removeGestureRecognizer(g)
            }
        }
    }
    
    @objc private func _tapAction() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
