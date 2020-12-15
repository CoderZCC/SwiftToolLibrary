//
//  UICollectionView-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/9.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    //MARK: 注册单元格 使用类名作为标记符
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func registerCell(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forCellWithReuseIdentifier: clsName)
        } else {
            self.register(cls, forCellWithReuseIdentifier: clsName)
        }
    }
    //MARK: 获取注册的单元格
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableCell <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "\(cls)".components(separatedBy: ".").last!, for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
    
    /// 注册组头
    ///
    /// - Parameter cls: 组头
    func registerHeader(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        } else {
            self.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组头 如果是通过xib方式创建的 在xib文件设置一下Class类型
    ///
    /// - Parameters:
    ///   - cls: 组头
    ///   - indexPath: indexPath
    /// - Returns: 组头
    func dequeueReusableHeader <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法 如果是通过xib方式创建的 在xib文件设置一下Class类型")
        }
        return header
    }
    
    /// 注册组尾
    ///
    /// - Parameter cls: 组尾
    func registerFooter(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        } else {
            self.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组尾
    ///
    /// - Parameters:
    ///   - cls: 组尾
    ///   - indexPath: indexPath
    /// - Returns: 组尾
    func dequeueReusableFooter <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let footer = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法 如果是通过xib方式创建的 在xib文件设置一下Class类型")
        }
        return footer
    }
}

