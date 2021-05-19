//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/19.
//

import UIKit

public extension UIScreen {
    
    static let width: CGFloat = UIScreen.main.bounds.width
    static let height: CGFloat = UIScreen.main.bounds.height
    
    @available(iOS 11.0, *)
    static let topSafeH: CGFloat = UIScreen.currentWindow?.safeAreaInsets.top ?? 10
    @available(iOS 11.0, *)
    static var bottomSafeH: CGFloat = UIScreen.currentWindow?.safeAreaInsets.bottom ?? 0
    @available(iOS 11.0, *)
    static let navBarHeight: CGFloat = UIScreen.topSafeH + 44
    @available(iOS 11.0, *)
    static let tabBarHeight: CGFloat = UIScreen.bottomSafeH + 49
    
    static var currentWindow: UIWindow? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.filter({ $0 is UIWindowScene }).first as? UIWindowScene
            window = scene?.windows.filter({ $0.isKeyWindow }).first
        } else {
            window = UIApplication.shared.delegate?.window ?? nil
        }
        if window == nil {
            fatalError("获取当前主窗口失败")
        }
        return window
    }
}
