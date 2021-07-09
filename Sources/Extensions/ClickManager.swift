//
//  ClickManager.swift
//  SwiftToolLibrary
//
//  Created by CC Z on 2021/7/9.
//

import UIKit

class ClickManager {
    static let `default`: ClickManager = ClickManager()
    
    
    
    @objc func clickAction(_ sender: UIButton) {
        print("click at \(Date()) with \(sender).")
    }
    
}
