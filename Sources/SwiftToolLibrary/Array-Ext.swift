//
//  Array-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/7.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension Array {
    
    /// 防止数组越界
    ///
    /// - Parameter index: 下标
    subscript(safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
