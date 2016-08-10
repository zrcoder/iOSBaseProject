//
//  GCDWrapper.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

public typealias DispatchQueue = dispatch_queue_t

public var gcdMainQueue: DispatchQueue {
    return dispatch_get_main_queue()
}


public func runAfter(seconds: Double, queue: dispatch_queue_t = dispatch_get_main_queue(), action: ()->()) {
    
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(time, queue, action)
    
}