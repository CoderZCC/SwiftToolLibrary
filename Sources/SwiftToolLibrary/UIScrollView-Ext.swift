//
//  UITableView-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/4.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

public extension UITableView {
    
    //MARK: 隐藏多余的线
    /// 隐藏多余的线
    func hiddeSurplusLine() {
        self.tableFooterView = UIView()
    }
    
    //MARK: 注册单元格 使用类名作为标记符
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func registerCell(cls: AnyClass) {
        let clsName: String = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forCellReuseIdentifier: clsName)
        } else {
            self.register(cls, forCellReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableCell <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
    
    /// 注册头
    /// - Parameter cls: cls
    func registerHeaderFooter(_ cls: AnyClass) {
        let clsName: String = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forHeaderFooterViewReuseIdentifier: clsName)
        } else {
            self.register(cls, forHeaderFooterViewReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的头尾
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableHeaderFooter <T> (cls: T.Type) -> T {
        guard let headerFooter = self.dequeueReusableHeaderFooterView(withIdentifier: "\(cls)") as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return headerFooter
    }
}
