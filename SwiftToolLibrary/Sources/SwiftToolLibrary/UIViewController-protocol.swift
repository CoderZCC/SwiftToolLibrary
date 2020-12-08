//
//  UIViewController-protocol.swift
//  HmmToCProject
//
//  Created by 北京摩学教育科技有限公司 on 2020/12/4.
//  Copyright © 2020 zcc. All rights reserved.
//

import UIKit

// MARK: -控制器相关协议
/// -当前的导航/试图控制器
public protocol UIViewControllerProtocol { }
extension UIViewControllerProtocol {
    
    /// 当前正在展示的导航控制器 - 请在˙主线程调用
    var currentNC: UINavigationController? {
        return self._getCurrentNC(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    private func _getCurrentNC(_ vc: UIViewController?) -> UINavigationController? {
        if vc?.presentedViewController != nil {
            return self._getCurrentNC(vc?.presentedViewController)
        } else if let tab = vc as? UITabBarController {
            return self._getCurrentNC(tab.selectedViewController)
        } else if let nav = vc as? UINavigationController {
            return nav
        }
        return nil
    }
    
    /// 当前正在展示的控制器 - 请在˙主线程调用
    var currentVC: UIViewController? {
        return self._getCurrentVC(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    private func _getCurrentVC(_ vc: UIViewController?) -> UIViewController? {
        if vc?.presentedViewController != nil {
            return self._getCurrentVC(vc?.presentedViewController)
        } else if let tab = vc as? UITabBarController {
            if let nav = tab.selectedViewController as? UINavigationController {
                return self._getCurrentVC(nav)
            } else {
                return tab.selectedViewController ?? tab
            }
        } else if let nav = vc as? UINavigationController {
            return nav.viewControllers.last ?? nav
        } else {
            return vc
        }
    }
}

// MARK: -push/present
extension UIViewControllerProtocol {
    
    /// 推出控制器
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: animated = true
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        self.currentNC?.pushViewController(viewController, animated: animated)
    }
    
    /// 弹出控制器
    /// - Parameter viewController: viewController
    func present(_ viewController: UIViewController) {
        self.currentVC?.present(viewController, animated: true, completion: nil)
    }
}
