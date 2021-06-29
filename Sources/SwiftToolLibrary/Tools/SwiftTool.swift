//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/31.
//

import UIKit

public struct SwiftTool {
    
    /// 震感反馈
    public static func shake(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
