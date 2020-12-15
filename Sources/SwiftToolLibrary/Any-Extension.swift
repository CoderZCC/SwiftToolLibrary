//
//  Any-Extension.swift
//  TestiOS
//
//  Created by 北京摩学教育科技有限公司 on 2020/11/16.
//

import Foundation

public extension NSObject {
    
    /// 动态添加属性
    ///
    /// - Parameters:
    ///   - key: 唯一值
    ///   - value: 保存的值
    func k_setAssociatedObject(key: String, value: Any?) {
        guard let keyHashValue = UnsafeRawPointer(bitPattern: key.hashValue) else {
            fatalError("k_setAssociatedObject-error")
        }
        objc_setAssociatedObject(self, keyHashValue, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    /// 获取属性值
    ///
    /// - Parameter key: 唯一值
    /// - Returns: 保存的值
    func k_getAssociatedObject(key: String) -> Any? {
        guard let keyHashValue = UnsafeRawPointer(bitPattern: key.hashValue) else {
            fatalError("k_getAssociatedObject-error")
        }
        return objc_getAssociatedObject(self, keyHashValue)
    }
}
