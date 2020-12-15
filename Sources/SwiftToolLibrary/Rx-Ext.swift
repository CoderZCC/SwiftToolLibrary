//
//  Rx-Ext.swift
//  HmmToCProject
//
//  Created by 北京摩学教育科技有限公司 on 2020/12/4.
//  Copyright © 2020 zcc. All rights reserved.
//

import UIKit

public extension UIButton {

    //MARK: UIButton添加点击事件
    /// UIButton添加点击事件
    ///
    /// - Parameters:
    ///   - events: 事件
    ///   - block: 回调
    func addTarget(events: UIControl.Event = .touchUpInside, block: @escaping(UIButton)->Void) {

        k_setAssociatedObject(key: "kUIButtonClickKey1", value: block)
        self.addTarget(self, action: #selector(_btnAction), for: events)
    }
    @objc func _btnAction() {

        if let block = k_getAssociatedObject(key: "kUIButtonClickKey") as? ()->Void {
            DispatchQueue.main.async {
                block()
            }
        } else if let block = k_getAssociatedObject(key: "kUIButtonClickKey1") as? (UIButton)->Void {
            DispatchQueue.main.async {
                block(self)
            }
        }
    }
}
