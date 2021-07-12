//
//  ViewController.swift
//  SwiftToolLibrary-Demo
//
//  Created by CC Z on 2021/7/2.
//

import UIKit
import SwiftToolLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.random
//        self._testTextView()
//        self._testCompressImage()
        self._testTextLimit()
    }
    
    
}

extension ViewController {
    
    func _testTextView() {
        let textView = UITextPlaceholderView(frame: CGRect(x: 10, y: 20, width: 300, height: 200))
        textView.backgroundColor = UIColor.white
        textView.placeholder("我是占位文字")
        textView.placeholderColor(UIColor.darkGray)
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.lineSpacing(4)
        
        self.view.addSubview(textView)
    }
    
    func _testCompressImage() {
        let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let original = UIImage(named: "img1")!
        
        print(original.size)
        
        let new = original.ex.compress(maxKbSize: 1024)
        let deal = UIImage(data: new ?? Data())
        print(deal?.size ?? 0)
        
        imgV.image = deal
        imgV.contentMode = .scaleAspectFit
        imgV.center = self.view.center
        imgV.layer.borderWidth = 1
        imgV.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(imgV)
    }
    
    func _testTextLimit() {
        
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        tf.backgroundColor = UIColor.white
        tf.center = self.view.center
        self.view.addSubview(tf)
        
        let tf2 = UITextField(frame: CGRect(x: tf.frame.minX, y: tf.frame.maxY + 20, width: 300, height: 30))
        tf2.backgroundColor = UIColor.white
        self.view.addSubview(tf2)
        
        tf.ex.maxTextLength(2)
        tf2.ex.maxTextLength(4)
    }
}

