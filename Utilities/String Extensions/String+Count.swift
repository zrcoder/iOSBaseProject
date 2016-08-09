//
//  String+Count.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

public extension String {
    
    /// Character count
    public var length: Int {
        return self.characters.count
    }
    
    /// Counts number of instances of the input inside String
    public func countOf(substring: String) -> Int {
        return componentsSeparatedByString(substring).count - 1
    }
    
    /// Returns count of words in string
    public var countOfWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpressionOptions())
        return regex?.numberOfMatchesInString(self, options: NSMatchingOptions(), range: NSRange(location: 0, length: self.length)) ?? 0
    }

    /// Returns count of paragraphs in string
    public var countOfParagraphs: Int {
        let regex = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpressionOptions())
        let str = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return (regex?.numberOfMatchesInString(str, options: NSMatchingOptions(), range: NSRange(location:0, length: str.length)) ?? -1) + 1
    }
    
}