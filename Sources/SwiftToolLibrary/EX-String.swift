//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import Foundation

extension String: EXCompatible { }
extension EX where T == String {
    
    /// 获取字节数 中文-2个 英文-1个
    var byteCount: Int {
        var allCount: Int = 0
        for (_, value) in self.value.enumerated() {
            if value >= "\u{4E00}" && value <= "\u{9FA5}" {
                allCount += 2
            } else {
                allCount += 1
            }
        }
        return allCount
    }
    
    
    
    
}
