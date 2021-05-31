//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

extension UIImage: EXCompatible { }
public extension EX where T == UIImage {
    
    // MARK: - 降低质量
    /// 压缩图片
    ///
    /// - Parameters:
    ///   - size: 新尺寸
    ///   - maxSize: 最大kb
    /// - Returns: 数据流
    func compress(size: CGSize? = nil, maxSize: Int) -> Data? {
        
        var cropImage: UIImage!
        if let size = size, size != CGSize.zero {
            cropImage = self._scaleSquareImage(newSize: size)
        } else {
            cropImage = self.value
        }
        //先判断当前质量是否满足要求，不满足再进行压缩
        var finallImageData = cropImage.jpegData(compressionQuality: 1.0)
        guard let sizeOrigin = finallImageData?.count else { return nil }
        let sizeOriginKB = sizeOrigin / 1024
        if sizeOriginKB <= maxSize {
            return finallImageData
        }
        
        //获取原图片宽高比
        let sourceImageAspectRatio = cropImage.size.width/cropImage.size.height
        //先调整分辨率
        var defaultSize = size ?? CGSize(width: 500, height: 500/sourceImageAspectRatio)
        var newImage: UIImage!
        if size == nil {
            newImage = cropImage.ex._newSizeImage(size: defaultSize)
        } else {
            newImage = cropImage
        }
        
        finallImageData = newImage.jpegData(compressionQuality: 1.0)
        
        //保存压缩系数
        let compressionQualityArr = NSMutableArray()
        let avg = CGFloat(1.0/250)
        var value = avg
        
        var i = 250
        repeat {
            i -= 1
            value = CGFloat(i)*avg
            compressionQualityArr.add(value)
        } while i >= 1
        
        /*
         调整大小
         说明：压缩系数数组compressionQualityArr是从大到小存储。
         */
        //思路：使用二分法搜索
        finallImageData = newImage.ex._halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], sourceData: finallImageData!, maxSize: maxSize)
        //如果还是未能压缩到指定大小，则进行降分辨率
        while finallImageData?.count == 0 {
            //每次降100分辨率
            let reduceWidth = 100.0
            let reduceHeight = 100.0/sourceImageAspectRatio
            if (defaultSize.width-CGFloat(reduceWidth)) <= 0 || (defaultSize.height-CGFloat(reduceHeight)) <= 0 {
                break
            }
            defaultSize = CGSize(width: (defaultSize.width-CGFloat(reduceWidth)), height: (defaultSize.height-CGFloat(reduceHeight)))
            let image = UIImage.init(data: newImage.jpegData(compressionQuality: compressionQualityArr.lastObject as! CGFloat)!)!.ex._newSizeImage(size: defaultSize)
            
            finallImageData = image.ex._halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], sourceData: image.jpegData(compressionQuality: 1.0)!, maxSize: maxSize)
        }
        
        return finallImageData
    }
    
    // MARK: - 调整图片分辨率/尺寸（等比例缩放）
    private func _newSizeImage(size: CGSize) -> UIImage {
        var newSize = CGSize(width: self.value.size.width, height: self.value.size.height)
        let tempHeight = newSize.height / size.height
        let tempWidth = newSize.width / size.width
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: self.value.size.width / tempWidth, height: self.value.size.height / tempWidth)
        } else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: self.value.size.width / tempHeight, height: self.value.size.height / tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        self.value.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
            index = start + (end - start)/2
            
            tempFinallImageData = self.value.jpegData(compressionQuality: arr[index])!
            
            let sizeOrigin = tempFinallImageData.count
            let sizeOriginKB = sizeOrigin / 1024
            
            print("当前降到的质量：\(sizeOriginKB)\n\(index)----\(arr[index])")
            
            if sizeOriginKB > maxSize {
                start = index + 1
            } else if sizeOriginKB < maxSize {
                if maxSize-sizeOriginKB < difference {
                    difference = maxSize-sizeOriginKB
                    tempData = tempFinallImageData
                }
                if index<=0 {
                    break
                }
                end = index - 1
            } else {
                break
            }
        }
        return tempData
    }
    
    /// 等比压缩，然后裁剪为想要的尺寸 // 好像不起作用慎用
    ///
    /// - Parameter newSize: 尺寸
    /// - Returns: 新图
    private func _scaleSquareImage(newSize: CGSize) -> UIImage? {
        let asecptImg = self._cropImageWith(newSize: newSize)
        return asecptImg.ex._resizeImage(with: newSize)
    }
    
    /// 从中心裁剪图片尺寸  // 好像不起作用慎用
    ///
    /// - Parameter size: 修改的尺寸
    /// - Returns: 新图片
    private func _cropImageWith(newSize: CGSize) -> UIImage {
        
        let imgWidth = self.value.size.width * self.value.scale
        let imgHeight = self.value.size.height * self.value.scale
        if newSize.width >= imgWidth && newSize.height >= imgHeight { return self.value }
        let scale = imgWidth / imgHeight
        var rect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
        
        if scale > newSize.width / newSize.height {
            
            rect.size.width = imgHeight * newSize.width / newSize.height
            rect.origin.x = (imgWidth - rect.size.width) / 2.0
            rect.size.height = imgHeight
            
        } else {
            
            rect.origin.y = (imgHeight - imgWidth / newSize.width * newSize.height) / 2.0
            rect.size.width = imgWidth
            rect.size.height = imgWidth / newSize.width * newSize.height
        }
        if let imgRef = self.value.cgImage?.cropping(to: rect) {
            return UIImage.init(cgImage: imgRef)
        }
        return self.value
    }
    
    /// 重新布局图片, 会被挤扁
    ///
    /// - Parameter newSize: 新尺寸
    /// - Returns: 新图片
    private func _resizeImage(with newSize: CGSize) -> UIImage {
        
        let newWidth = newSize.width
        let newHeight = newSize.height
        
        let width = self.value.size.width * self.value.scale
        let height = self.value.size.height * self.value.scale
        
        if (width != newWidth) || (height != newHeight) {
            
            UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
            self.value.draw(in: CGRect(x: 0.0, y: 0.0, width: newWidth, height: newHeight))
            
            let resized = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return resized ?? self.value
        }
        return self.value
    }
}
