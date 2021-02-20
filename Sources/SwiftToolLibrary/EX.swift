//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
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
