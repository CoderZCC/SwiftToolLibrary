//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension UIImage: EXCompatible { }
public extension EX where T: UIImage {
    
    /// 压缩图片
    /// - Parameter maxLength: kb
    /// - Returns: 新图
    func compressImage(toKb size: Int) -> UIImage {
        let num: Int = 1000
        let maxLength: Int = size * num
        var compression: CGFloat = 1
        guard var data = self.value.jpegData(compressionQuality: compression) ?? self.value.pngData(),
            data.count > maxLength else { return self.value }
        debugPrint("<====")
        debugPrint("Before compressing quality, image size =", data.count / num, "KB")
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.value.jpegData(compressionQuality: compression)!
            debugPrint("[compress]: Compression =", compression)
            debugPrint("[compress]: In compressing quality loop, image size =", data.count / num, "KB")
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        debugPrint("[compress]: After compressing quality, image size =", data.count / num, "KB")
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return resultImage }
        
        // Compress by size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            debugPrint("[compress]: Ratio =", ratio)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
            debugPrint("[compress]: In compressing size loop, image size =", data.count / num, "KB")
        }
        debugPrint("[compress]: After compressing size loop, image size =", data.count / num, "KB")
        debugPrint("====>")
        return resultImage
    }
}

public extension EX where T: UIImage {
    
    /// 调整图片分辨率/尺寸（等比例缩放）
    ///
    /// - Parameter height: 设置的新高度
    /// - Returns: 新图
    func resizeScaleToFit(with height: CGFloat) -> UIImage {
        let width = height / self.value.size.height * self.value.size.width
        let newImgSize = CGSize(width: width, height: height)
        return self._resize(with: newImgSize)
    }
    
    /// 调整图片分辨率/尺寸（等比例缩放）
    ///
    /// - Parameter size: 设置的大小
    /// - Returns: 新图
    func resizeScaleToFit(with size: CGSize) -> UIImage {
        var newSize = CGSize(width: self.value.size.width, height: self.value.size.height)
        let tempHeight = newSize.height / size.height
        let tempWidth = newSize.width / size.width
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: self.value.size.width / tempWidth, height: self.value.size.height / tempWidth)
        } else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: self.value.size.width / tempHeight, height: self.value.size.height / tempHeight)
        }
        return self._resize(with: newSize)
    }
    
    private func _resize(with final: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(final, true, UIScreen.main.scale)
        self.value.draw(in: CGRect(x: 0, y: 0, width: final.width, height: final.height))
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage ?? self.value
    }
}

public extension EX where T: UIImage {
    
    /// 裁剪指定区域 按照图片原始尺寸裁剪
    /// - Parameter rect: CGRect
    /// - Returns: 新图
    func crop(with rect: CGRect) -> UIImage {
        if let imgRef = self.value.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: imgRef)
        }
        return self.value
    }

    /// 从图片中间开始裁剪
    /// - Parameter size: size
    /// - Returns: 新图
    func cropFromCenter(with size: CGSize) -> UIImage {
        let imgSize = self.value.size
        if size.width >= imgSize.width && size.height >= imgSize.height {
            return self.value
        }
        let realWidth = min(size.width, imgSize.width)
        let realHeight = min(size.height, imgSize.height)
        let rect = CGRect(x: (imgSize.width - realWidth) / 2.0, y: (imgSize.height - realHeight) / 2.0, width: realWidth, height: realHeight)
        return self.crop(with: rect)
    }

    /// 中心裁剪为正方形
    var squareImg: UIImage {
        let imgSize = self.value.size
        if imgSize.width == imgSize.height {
            return self.value
        }
        let realWidth = min(imgSize.width, imgSize.height)
        let realHeight = realWidth
        let rect = CGRect(x: (imgSize.width - realWidth) / 2.0, y: (imgSize.height - realHeight) / 2.0, width: realWidth, height: realHeight)
        return self.crop(with: rect)
    }
}
