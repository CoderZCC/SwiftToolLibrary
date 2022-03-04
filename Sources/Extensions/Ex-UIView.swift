//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension UIView: EXCompatible { }
public extension EX where T: UIView {
    
    /// 设置圆角 clipsToBounds = true
    var cornerRadius: CGFloat {
        set {
            self.value.layer.cornerRadius = newValue
            self.value.clipsToBounds = true
        }
        get {
            self.value.layer.cornerRadius
        }
    }
    
    //MARK: 设置特定的圆角
    /// 设置特定的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置
    ///   - radii: 圆角
    func setCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, size: CGSize? = nil) {
        if let size = size, size != .zero {
            self.value.layer.mask?.removeFromSuperlayer()
            let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
            let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = rect
            maskLayer.path = maskPath.cgPath
            self.value.layer.mask = maskLayer
        } else if self.value.bounds.size != .zero {
            self.setCorner(byRoundingCorners: corners, radii: radii, size: self.value.bounds.size)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.setCorner(byRoundingCorners: corners, radii: radii, size: size)
            }
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
        self.gestureRecognizers?.removeAll(where: { $0 is _TapGestureRecognizer })
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
