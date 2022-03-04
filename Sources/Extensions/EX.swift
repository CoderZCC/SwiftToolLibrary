//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import Foundation

public struct EX<T> {
    public var value: T
}

public protocol EXCompatible { }
extension EXCompatible {
    public var ex: EX<Self> {
        set { }
        get { EX(value: self) }
    }
}
