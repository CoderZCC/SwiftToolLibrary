//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension UIView: EXCompatible { }
public extension EX where T: UIView {
    
    //MARK: 设置特定的圆角
    /// 设置特定的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置
    ///   - radii: 圆角
    func setCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        if self.value.bounds == CGRect.zero {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.setCorner(byRoundingCorners: corners, radii: radii)
            }
        } else {
            if self.value.layer.mask != nil { return }
            let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0.0, y: 0.0, width: self.value.bounds.width, height: self.value.bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.value.bounds.width, height: self.value.bounds.height)
            maskLayer.path = maskPath.cgPath
            self.value.layer.mask = maskLayer
        }
    }
}
