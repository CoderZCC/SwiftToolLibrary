//
//  UIView-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/4.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// 设置圆角
    var cornerRadius: CGFloat? {
        set {
            self.layer.cornerRadius = newValue ?? 0.0
            self.clipsToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
        
    //MARK: 设置特定的圆角
    /// 设置特定的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置
    ///   - radii: 圆角
    func setCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        if self.bounds == CGRect.zero {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.setCorner(byRoundingCorners: corners, radii: radii)
            }
        } else {
            if self.layer.mask != nil { return }
            let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
    }
}
