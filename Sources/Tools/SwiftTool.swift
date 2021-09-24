//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

public enum SwiftTool { }
public extension SwiftTool {
    /// 震感反馈
    static func shake(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
