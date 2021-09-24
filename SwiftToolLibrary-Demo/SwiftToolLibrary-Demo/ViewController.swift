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

func test() {
    let text = "达拉拉斯打死了卡坚实的开了多久奥斯卡了大家按时来看看大家安利;SD卡;SD卡;打卡老师;扩大;螺丝刀卡;螺丝孔;看打算肯德基奥施康定哈斯拉斯拉斯拉斯加"
    let style = NSMutableParagraphStyle()
    style.minimumLineHeight = 22
    style.maximumLineHeight = 22
    let att = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular), .paragraphStyle: style])
    
    let lines = att.az_lines(in: 300)
    for line in lines {
        let runs = CTLineGetGlyphRuns(line) as! [CTRun]
        // 每行的内容
        var content: String = ""
        for run in runs {
            let range = CTRunGetStringRange(run)
            let realRange = NSRange(location: range.location, length: range.length)
            // 第一行的文案
            content += text[Range(realRange, in: text)!]
        }
        printLog(content)
    }
}

extension NSAttributedString {
    
    /// 最后一行
    /// - Parameter zone: size
    /// - Returns: (最后一行是哪行, 最后一行的宽度)
    func az_lastLineWidth(in zone: CGSize) -> (Int, CGFloat) {
        let path = CGMutablePath()
        let size = CGSize(width: ceil(Double(zone.width)), height: ceil(Double(zone.height)))
        path.addRect(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let ctFramesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        let ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, self.length), path, nil)
        let ctLines = CTFrameGetLines(ctFrame) as! [CTLine]
        if let ctLine = ctLines.last {
            return (ctLines.count, CGFloat(ceil(Double(CTLineGetBoundsWithOptions(ctLine, CTLineBoundsOptions(rawValue: 0)).width))))
        }
        return (ctLines.count, 0.0)
    }
    
    /// 获取富文本所占的行数
    /// - Parameter width: 最大宽度
    /// - Returns: 行数
    func az_lines(in width: CGFloat) -> [CTLine] {
        let setter = CTTypesetterCreateWithAttributedString(self as CFAttributedString)
        var lastIndex: CFIndex = 0
        var lines: [CTLine] = []
        while true {
            let lineCharacterCount = CTTypesetterSuggestLineBreak(setter, lastIndex, Double(width))
            if lineCharacterCount > 0 {
                let line = CTTypesetterCreateLine(setter, CFRange(location: lastIndex, length: lineCharacterCount))
                lines.append(line)
                lastIndex += lineCharacterCount
            } else {
                break
            }
        }
        return lines
    }
}
