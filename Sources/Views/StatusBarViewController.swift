//
//  StatusBarViewController.swift
//  SwiftToolLibrary
//
//  Created by CC Z on 2021/7/30.
//

import UIKit

// MARK: -电池条基类
public class StatusBarViewController: UIViewController {

    public enum StatusBarEnum {
        case light, dark
    }
    
    public var isHiddenStausBar: Bool = false {
        didSet {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }
    public var statusBarStyle: StatusBarEnum = .dark {
        didSet {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.statusBarStyle = .dark
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.statusBarStyle == .light {
            return .lightContent
        } else if self.statusBarStyle == .dark, #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
    public override var prefersStatusBarHidden: Bool {
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

    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}
