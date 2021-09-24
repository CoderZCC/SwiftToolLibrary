//
//  File.swift
//  
//
//  Created by CC Z on 2021/6/27.
//

import UIKit

/// 物理屏幕宽度
public let kScreenWidth: CGFloat = UIScreen.main.bounds.width
/// 物理屏幕高度
public let kScreenHeight: CGFloat = UIScreen.main.bounds.height
/// 物理屏幕尺寸
public let kScreenSize: CGSize = UIScreen.main.bounds.size

/// 顶部安全区域 最小20
public let kTopSafeH: CGFloat = (kCurrentWindow?.safeAreaInsets.top ?? 0) > 20 ? (kCurrentWindow?.safeAreaInsets.top ?? 0) : 20
/// 低部安全区域 最小0
public let kBottomSafeH: CGFloat = kCurrentWindow?.safeAreaInsets.bottom ?? 0

/// 导航栏高度
public let kNavBarHeight: CGFloat = kTopSafeH + 44
/// 标签栏高度
public let kTabBarHeight: CGFloat = kBottomSafeH + 49

/// 当前活跃的窗口
public var kCurrentWindow: UIWindow? {
    var window: UIWindow?
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.filter({ $0 is UIWindowScene }).first as? UIWindowScene
        if scene?.windows.count == 1 {
            window = scene?.windows.first
        } else {
            window = scene?.windows.filter({ $0.isKeyWindow }).first
        }
    } else {
        window = UIApplication.shared.delegate?.window ?? nil
    }
    if window == nil {
        fatalError("获取当前主窗口失败")
    }
    return window
}

/// 闭包配置UI
public func kConfigureUI<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}

