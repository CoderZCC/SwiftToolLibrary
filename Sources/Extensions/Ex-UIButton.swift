//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

public extension UIButton {

    typealias ButtonTargetClosure = (UIButton)->Void
    static private let keyEx: String = "UIButtonAddTargetEx"

    /// 添加点击事件
    /// - Parameters:
    ///   - event: UIControl.Event
    ///   - closure: (UIButton)->Void
    func addTarget(event: UIControl.Event = .touchUpInside, _ closure: @escaping ButtonTargetClosure) {
        k_setAssociatedObject(key: UIButton.keyEx, value: closure)
        self.addTarget(self, action: #selector(_clickActionEx), for: event)
    }

    @objc private func _clickActionEx(_ sender: UIButton) {
        guard let closure = k_getAssociatedObject(key: UIButton.keyEx) as? ButtonTargetClosure else { return }
        closure(sender)
    }
}
