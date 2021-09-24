//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/19.
//

import UIKit

/// 扩大点击区域
open class UIViewLarger: UIView {
    
    /// 扩大点击区域 默认是 (10, 10) 向四周扩展10pt
    public var offset: CGSize = CGSize(width: 10, height: 10)
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 负值是方法响应范围
        return self.bounds.insetBy(dx: -self.offset.width, dy: -self.offset.height).contains(point)
    }
}

/// 按钮点击扩大 四周10pt
open class UIButtonLarger: UIButton {
    
    /// 扩大点击区域 默认是 (10, 10) 向四周扩展10pt
    public var offset: CGSize = CGSize(width: 10, height: 10)
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 负值是方法响应范围
        return self.bounds.insetBy(dx: -self.offset.width, dy: -self.offset.height).contains(point)
    }
}
