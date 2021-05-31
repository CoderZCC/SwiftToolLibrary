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

public extension Sequence {
    
    /// 按个数分组
    /// - Parameter clumpsize: 2
    /// - Returns: [[1, 2], [3, 4], [5, 6]]
    func clump(by clumpsize:Int) -> [[Element]] {
        let slices : [[Element]] = self.reduce(into:[]) {
            memo, cur in
            if memo.count == 0 {
                return memo.append([cur])
            }
            if (memo.last?.count ?? 0) < clumpsize {
                memo.append(memo.removeLast() + [cur])
            } else {
                memo.append([cur])
            }
        }
        return slices
    }
}

