//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import Foundation

struct EX<T> {
    var value: T
}

protocol EXCompatible { }
extension EXCompatible {
    var ex: EX<Self> {
        set {}
        get { EX(value: self) }
    }
}
