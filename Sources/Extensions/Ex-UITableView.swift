//
//  File.swift
//  
//
//  Created by ZCC on 2021/2/20.
//

import UIKit

public extension EX where T: UITableView {
    
    /// 隐藏多余的线
    func hiddeSurplusLine() {
        self.value.tableFooterView = UIView()
    }
    
    /// 自动计算行高
    func autoJudgeCellHeight() {
        self.value.rowHeight = UITableView.automaticDimension
        self.value.estimatedRowHeight = 0.1
    }
    
    /// 自动计算头
    func autoJudgeSectionHeaderHeight() {
        self.value.sectionHeaderHeight = UITableView.automaticDimension
        self.value.estimatedSectionHeaderHeight = 0.1
    }
    
    /// 自动计算尾
    func autoJudgeSectionFooterHeight() {
        self.value.sectionFooterHeight = UITableView.automaticDimension
        self.value.estimatedSectionFooterHeight = 0.1
    }
    
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func registerCell(_ cls: AnyClass) {
        let clsName: String = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.value.register(UINib(nibName: clsName, bundle: nil), forCellReuseIdentifier: clsName)
        } else {
            self.value.register(cls, forCellReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableCell <T> (_ cls: T.Type, _ indexPath: IndexPath) -> T {
        guard let cell = self.value.dequeueReusableCell(withIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
    
    /// 注册头尾
    /// - Parameter cls: cls
    func registerHeaderFooter(_ cls: AnyClass) {
        let clsName: String = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.value.register(UINib(nibName: clsName, bundle: nil), forHeaderFooterViewReuseIdentifier: clsName)
        } else {
            self.value.register(cls, forHeaderFooterViewReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的头尾
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func dequeueReusableHeaderFooter <T> (_ cls: T.Type) -> T {
        guard let headerFooter = self.value.dequeueReusableHeaderFooterView(withIdentifier: "\(cls)") as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return headerFooter
    }
}
