//
//  File.swift
//  
//
//  Created by CC Z on 2021/6/27.
//

import UIKit

func kConfigureUI<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}
