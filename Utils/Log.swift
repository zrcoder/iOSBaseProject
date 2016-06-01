//
//  Log.swift
//  iOSBaseProject
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation


/**
 print when debuging
 */
func log<T>(message:T) {
    #if DEBUG  //tip : build settings -> Swift Compiler - Custom Flags -> Other Swift Flags -> debug = -D DEBUG
        print("\(message)")
    #endif
}

/**
 print file name, line number and method name when debuging
 */
func dLog(file:String = #file, line:Int = #line, function:String = #function) {
    #if DEBUG
        print("⭐️\((file as NSString).lastPathComponent)🔸\(line) 🌜\(function)🌛")
    #endif
}

/**
 print detail log (starts with file name, line number and method name) when debuging
 */
func dLog<T>(message: T, file:String = #file, line:Int = #line, function:String = #function) {
    #if DEBUG
        print("⭐️\((file as NSString).lastPathComponent)🔸\(line) 🌜\(function)🌛 \n\(message)")
    #endif
}





