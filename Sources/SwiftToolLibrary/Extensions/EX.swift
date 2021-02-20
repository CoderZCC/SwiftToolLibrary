//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import Foundation

public struct EX<T> {
    var value: T
}

public protocol EXCompatible { }
extension EXCompatible {
    public var ex: EX<Self> {
        set {}
        get { EX(value: self) }
    }
}
//extension EXCompatible {
//    public static var ex: EX<Self>.Type {
//        set {}
//        get { EX.self }
//    }
//}
//
//class Person: EXCompatible {
//
//}
//
//extension EX where T == Person {
//    static func test() {
//
//    }
//}
//
//func test() {
//
//    Person.ex.test()
//}
