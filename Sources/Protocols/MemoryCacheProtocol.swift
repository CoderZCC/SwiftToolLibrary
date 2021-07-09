//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/19.
//

import Foundation

/// 内存存储
public protocol MemoryCacheProtocol { }
public extension MemoryCacheProtocol {
    
    func save(_ value: Any?) {
        kMemoryCahce.setObject(value as AnyObject, forKey: self._cacheKey)
    }
    
    func read() -> Any? {
        kMemoryCahce.object(forKey: self._cacheKey)
    }
    
    func delete() {
        kMemoryCahce.removeObject(forKey: self._cacheKey)
    }
    
    static func deleteAll() {
        kMemoryCahce.removeAllObjects()
    }
}

private let kMemoryCahce: NSCache = NSCache<AnyObject, AnyObject>()

private extension MemoryCacheProtocol {
    var _cacheKey: AnyObject {
        "MemoryCache-\(self)" as AnyObject
    }
}
