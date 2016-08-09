//
//  String+Base.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

extension String {
    
    /// Checks if string is empty or consists only of whitespace and newline characters
    public var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    /// Checking if String contains input
    public func contains(subString: String) -> Bool {
        return self.rangeOfString(subString) != nil
    }
    
    /// Checking if String contains input with comparing options
    public func contains(subString: String, compareOption: NSStringCompareOptions) -> Bool {
        return self.rangeOfString(subString, options: compareOption) != nil
    }
    
    /// Checks if String contains Emoji
    public func containsEmoji() -> Bool {
        for i in 0...characters.count {
            let c: unichar = (self as NSString).characterAtIndex(i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    
    /// Trims white space and new line characters
    public mutating func trim() {
        self = self.trimmed()
    }
    
    /// Trims white space and new line characters, returns a new string
    public func trimmed() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    /// split string using a spearator string, returns an array of string
    public func split(separator: String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }
    
    /// split string with delimiters, returns an array of string
    public func split(characters: NSCharacterSet) -> [String] {
        return self.componentsSeparatedByCharactersInSet(characters)
    }
}
