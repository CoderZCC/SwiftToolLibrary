//
//  File.swift
//  
//
//  Created by 北京摩学教育科技有限公司 on 2021/2/20.
//

import UIKit

extension Data: EXCompatible { }
public extension EX where T == Data {
    
    /// JsonData转Model模型
    /// - Parameter model: NSObject.self
    /// - Returns: T?
    func convert <T: Decodable>(to model: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(model, from: self.value)
        } catch {
            debugPrint("\(String(data: self.value, encoding: .utf8) ?? "")\n convert:\(error)")
            return nil
        }
    }
}

// MARK: -对象转Json串
public extension Collection {
    
    /// 转为Json字符串
    /// - Returns: json串
    func toJsonStr() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data: data, encoding: String.Encoding.utf8)
        }
        return nil
    }
    
    /// 转为Data
    /// - Returns: Data
    func toData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
}
