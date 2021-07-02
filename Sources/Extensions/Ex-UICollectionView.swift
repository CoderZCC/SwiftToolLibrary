//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

public extension EX where T == UICollectionView {
    
    //MARK: 注册单元格 使用类名作为标记符
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func registerCell(_ cls: AnyClass) {
        let clsName = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.value.register(UINib(nibName: clsName, bundle: nil), forCellWithReuseIdentifier: clsName)
        } else {
            self.value.register(cls, forCellWithReuseIdentifier: clsName)
        }
    }
    //MARK: 获取注册的单元格
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableCell <T> (_ cls: T.Type, _ indexPath: IndexPath) -> T {
        guard let cell = self.value.dequeueReusableCell(withReuseIdentifier: "\(cls)".components(separatedBy: ".").last!, for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
    
    /// 注册组头
    ///
    /// - Parameter cls: 组头
    func registerHeader(_ cls: AnyClass) {
        let clsName = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.value.register(UINib(nibName: clsName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        } else {
            self.value.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组头 如果是通过xib方式创建的 在xib文件设置一下Class类型
    ///
    /// - Parameters:
    ///   - cls: 组头
    ///   - indexPath: indexPath
    /// - Returns: 组头
    func dequeueReusableHeader <T> (_ cls: T.Type, _ indexPath: IndexPath) -> T {
        guard let header = self.value.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法 如果是通过xib方式创建的 在xib文件设置一下Class类型")
        }
        return header
    }
    
    /// 注册组尾
    ///
    /// - Parameter cls: 组尾
    func registerFooter(_ cls: AnyClass) {
        let clsName = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.value.register(UINib(nibName: clsName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        } else {
            self.value.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组尾
    ///
    /// - Parameters:
    ///   - cls: 组尾
    ///   - indexPath: indexPath
    /// - Returns: 组尾
    func dequeueReusableFooter <T> (_ cls: T.Type, _ indexPath: IndexPath) -> T {
        guard let footer = self.value.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法 如果是通过xib方式创建的 在xib文件设置一下Class类型")
        }
        return footer
    }
}
