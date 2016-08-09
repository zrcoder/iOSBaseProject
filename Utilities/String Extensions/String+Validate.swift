//
//  String+Validate.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

extension String {
    
    ///  Returns true if String is Email
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let firstMatch = dataDetector?.firstMatchInString(self, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: characters.count))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.URL?.scheme == "mailto")
    }
    
    /// Returns true if String is a number
    public var isNumber: Bool {
        if let _ = NSNumberFormatter().numberFromString(self) {
            return true
        }
        return false
    }

}