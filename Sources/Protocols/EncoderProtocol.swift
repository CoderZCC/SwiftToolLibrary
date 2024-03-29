//
//  EnCodableProtocol.swift
//  SwiftToolLibrary
//
//  Created by CC Z on 2021/8/25.
//

import Foundation

public protocol EncodableToDict: Encodable { }
public extension EncodableToDict {
    
    var toData: Data? {
        try? JSONEncoder().encode(self)
    }
    
    var toDict: [String: Any]? {
        if let data = self.toData {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }
        return nil
    }
}
