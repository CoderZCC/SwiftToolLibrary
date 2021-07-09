//
//  Async.swift
//  TestiOS
//
//  Created by ZCC on 2020/10/13.
//

import Foundation

/// 异步工具
public struct Asyncs {
    
    public typealias _Task = ()->Void
    
    /// 主线程操作
    /// - Parameters:
    ///   - mainTask: 主线程执行任务
    public static func asyncOnMain(_ mainTask: @escaping _Task) {
        let item = DispatchWorkItem(block: mainTask)
        DispatchQueue.main.async(execute: item)
    }
    
    /// 异步操作
    /// - Parameters:
    ///   - task: 子线程执行任务
    ///   - mainTask: 主线程执行任务
    public static func async(_ task: @escaping _Task, _ mainTask: _Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let m = mainTask {
            item.notify(queue: DispatchQueue.main, execute: m)
        }
    }
    
    /// 主线程延迟执行
    /// - Parameters:
    ///   - seconds: 秒
    ///   - mainTask: 需要执行的任务
    /// - Returns: DispatchWorkItem可取消
    @discardableResult
    public static func asyncDelay(_ seconds: TimeInterval, _ mainTask: @escaping _Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: mainTask)
        if seconds > 0 {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + seconds, execute: item)
        } else {
            DispatchQueue.main.async(execute: item)
        }
        return item
    }
}
