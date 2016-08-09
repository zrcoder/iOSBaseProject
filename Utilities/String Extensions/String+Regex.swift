//
//  String+Regex.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

extension String {
    
    /// Find matches of regular expression in string
    public func matchesForRegexInText(regex: String!) -> [String] {
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        let results = regex?.matchesInString(self, options: [], range: NSRange(location: 0, length: self.length)) ?? []
        return results.map { self.substringWithRange(self.rangeFromNSRange($0.range)!) }
    }
    
    
    internal func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }

}