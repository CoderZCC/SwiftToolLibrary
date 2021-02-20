//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import Foundation

public extension Array {
    
    /// 防止数组越界
    ///
    /// - Parameter index: 下标
    subscript(safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
