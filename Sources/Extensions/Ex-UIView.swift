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

public extension UIView {
    
    typealias UIViewTapClosure = (UITapGestureRecognizer)->Void
    static private let keyEx: String = "UIButtonAddTargetEx"
    private class _TapGestureRecognizer: UITapGestureRecognizer { }
    
    /// 添加点击事件
    /// - Parameter closure: (UITapGestureRecognizer)->Void
    func addTapGesure(_ closure: @escaping UIViewTapClosure) {
        if self.gestureRecognizers?.contains(where: { $0 is _TapGestureRecognizer }) ?? false {
            for s in self.gestureRecognizers ?? [] where s is _TapGestureRecognizer {
                self.removeGestureRecognizer(s)
            }
        }
        k_setAssociatedObject(key: UIView.keyEx, value: closure)
        self.isUserInteractionEnabled = true
        let tap = _TapGestureRecognizer(target: self, action: #selector(_tapActionEx))
        tap.delaysTouchesBegan = false
        tap.delaysTouchesEnded = false
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    @objc private func _tapActionEx(_ tap: UITapGestureRecognizer) {
        guard let closure = k_getAssociatedObject(key: UIView.keyEx) as? UIViewTapClosure else { return }
        closure(tap)
    }
}
