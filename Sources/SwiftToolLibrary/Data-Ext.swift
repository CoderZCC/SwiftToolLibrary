//
//  Data-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/5.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

// MARK: -数据转模型
public extension Data {
    
    /// JsonData转Model模型
    /// - Parameter model: NSObject.self
    /// - Returns: T?
    func convert <T: Decodable>(to model: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(model, from: self)
        } catch {
            debugPrint("\(String(data: self, encoding: .utf8) ?? "")\n convert:\(error)")
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

public extension String {
    
    /// 转对象
    /// - Returns: Any
    func toObject() -> Any? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
    }
}
