//
//  StatusBarViewController.swift
//  SwiftToolLibrary
//
//  Created by CC Z on 2021/7/30.
//

import UIKit

// MARK: -电池条基类
open class StatusBarViewController: UIViewController {

    public enum StatusBarEnum {
        case light, dark
    }
    
    open var isHiddenStausBar: Bool = false {
        didSet {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }
    open var statusBarStyle: StatusBarEnum = .dark {
        didSet {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.statusBarStyle == .light {
            return .lightContent
        } else if self.statusBarStyle == .dark, #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
    open override var prefersStatusBarHidden: Bool {
        self.isHiddenStausBar
    }
}

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}
