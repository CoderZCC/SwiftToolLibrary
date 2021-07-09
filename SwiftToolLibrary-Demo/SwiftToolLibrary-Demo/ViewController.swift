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
        self._testCompressImage()
    }
    
    
}

extension ViewController {
    
    func _testTextView() {
        let textView = UITextPlaceholderView(frame: CGRect(x: 10, y: 20, width: 300, height: 200))
        textView.backgroundColor = UIColor.white
        textView.placeholder("我是展位文字")
        textView.placeholderColor(UIColor.darkGray)
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.lineSpacing(4)
        
        self.view.addSubview(textView)
    }
    
    func _testCompressImage() {
        let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let original = UIImage(named: "img1")!
        
        print(original.pngData()?.count)
        print(original.size)
        
        let new = original.ex.compress(maxKbSize: 1024)
        print(new?.count.ex.size)
        let deal = UIImage(data: new ?? Data())
        print(deal?.size)
        
        imgV.image = deal
        imgV.contentMode = .scaleAspectFit
        imgV.center = self.view.center
        imgV.layer.borderWidth = 1
        imgV.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(imgV)
        
        
    }
}
