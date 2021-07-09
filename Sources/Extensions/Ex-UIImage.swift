//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension UIImage: EXCompatible { }
public extension EX where T: UIImage {
    
    // MARK: - 降低质量
    /// 压缩图片
    ///
    /// - Parameters:
    ///   - size: 新尺寸
    ///   - maxSize: 最大kb
    /// - Returns: 数据流
    func compress(size: CGSize? = nil, maxKbSize: Int) -> Data? {
        let cropImage: UIImage
        if let size = size, size != CGSize.zero {
            cropImage = self.resizeScaleToFit(with: size)
        } else {
            cropImage = self.value
        }
        //先判断当前质量是否满足要求，不满足再进行压缩
        var finallImageData = cropImage.pngData() ?? cropImage.jpegData(compressionQuality: 1.0)
        guard let sizeOrigin = finallImageData?.count else { return nil }
        let sizeOriginKB = sizeOrigin / 1024
        if sizeOriginKB <= maxKbSize {
            return finallImageData
        }
        
        //获取原图片宽高比
        let sourceImageAspectRatio = cropImage.size.width / cropImage.size.height
        //先调整分辨率
        var defaultSize = size ?? CGSize(width: 500, height: 500 / sourceImageAspectRatio)
        var newImage: UIImage!
        if size == nil {
            newImage = cropImage.ex.resizeScaleToFit(with: defaultSize)
        } else {
            newImage = cropImage
        }
        
        finallImageData = newImage.jpegData(compressionQuality: 1.0)
        
        //保存压缩系数
        let compressionQualityArr = NSMutableArray()
        let avg = CGFloat(1.0 / 250)
        var value = avg
        
        var i = 250
        repeat {
            i -= 1
            value = CGFloat(i) * avg
            compressionQualityArr.add(value)
        } while i >= 1
        
        /*
         调整大小
         说明：压缩系数数组compressionQualityArr是从大到小存储。
         */
        //思路：使用二分法搜索
        finallImageData = newImage.ex._halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], sourceData: finallImageData!, maxSize: maxKbSize)
        //如果还是未能压缩到指定大小，则进行降分辨率
        while finallImageData?.count == 0 {
            //每次降100分辨率
            let reduceWidth = 100.0
            let reduceHeight = 100.0 / sourceImageAspectRatio
            if (defaultSize.width - CGFloat(reduceWidth)) <= 0 || (defaultSize.height - CGFloat(reduceHeight)) <= 0 {
                break
            }
            defaultSize = CGSize(width: (defaultSize.width-CGFloat(reduceWidth)), height: (defaultSize.height-CGFloat(reduceHeight)))
            let image = UIImage.init(data: newImage.jpegData(compressionQuality: compressionQualityArr.lastObject as! CGFloat)!)!.ex.resizeScaleToFit(with: defaultSize)
            
            finallImageData = image.ex._halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], sourceData: image.jpegData(compressionQuality: 1.0)!, maxSize: maxKbSize)
        }
        
        return finallImageData
    }
        
    // MARK: - 二分法
    private func _halfFuntion(arr: [CGFloat], sourceData finallImageData: Data, maxSize: Int) -> Data? {
        var tempFinallImageData = finallImageData
        
        var tempData = Data.init()
        var start = 0
        var end = arr.count - 1
        var index = 0
        
        var difference = Int.max
        while start <= end {
            index = start + (end - start) / 2
            
            tempFinallImageData = self.value.jpegData(compressionQuality: arr[index])!
            
            let sizeOrigin = tempFinallImageData.count
            let sizeOriginKB = sizeOrigin / 1024
            
            print("当前降到的质量：\(sizeOriginKB)\n\(index)----\(arr[index])")
            
            if sizeOriginKB > maxSize {
                start = index + 1
            } else if sizeOriginKB < maxSize {
                if maxSize - sizeOriginKB < difference {
                    difference = maxSize - sizeOriginKB
                    tempData = tempFinallImageData
                }
                if index <= 0 {
                    break
                }
                end = index - 1
            } else {
                break
            }
        }
        return tempData
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
