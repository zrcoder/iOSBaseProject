//
//  FilePath.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

public var documentPath: String {
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
}

public func documentPathFor(fileName: String) -> String {
    return (documentPath as NSString).stringByAppendingPathComponent(fileName)
}

public func appGroupDocumentPath(appGroupId: String) -> String? {
    let url = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(appGroupId)
    let path = url?.absoluteString.stringByReplacingOccurrencesOfString("file:", withString: "", options: .LiteralSearch, range: nil)
    return path
}

public func bundlePathFor(fileName: String) -> String {
    return (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent(fileName)
}