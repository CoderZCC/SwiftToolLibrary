//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

struct SwiftTool {
    
    /// 震感反馈
    static func shake(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

import WidgetKit
extension SwiftTool {
    
    static func reloadWidget() {
        if #available(iOS 14.0, *) {
            #if arch(arm64) || arch(i386) || arch(x86_64)
            WidgetCenter.shared.reloadAllTimelines()
            #endif
        }
    }
}
