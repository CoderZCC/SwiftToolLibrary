//
//  ViewController.swift
//  Example-iOS
//
//  Created by CC Z on 2021/5/31.
//

import UIKit
import SwiftToolLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        UIView().ex.setCorner(byRoundingCorners: .allCorners, radii: 10)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textView.center = self.view.center
        textView.placeholder("占位文字")
        
        self.view.addSubview(textView)
    }
}
