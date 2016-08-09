//
//  String+Index.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

// MARK: - Subscript for index, position of substring and so on
public extension String {
    /// Cut string from integerIndex to the end
    public subscript(index: Int) -> Character {
        let index = startIndex.advancedBy(index)
        return self[index]
    }
    
    /// Cut string from range
    public subscript(range: Range<Int>) -> String {
        let start = startIndex.advancedBy(range.startIndex)
        let end = startIndex.advancedBy(range.endIndex)
        let range = start..<end
        return self[range]
    }
    
    /// Position of begining character of substing
    public func indexOf(subString: String, caseInsensitive: Bool = false, fromEnd: Bool = false) -> Int {
        if subString.isEmpty {
            return -1
        }
        var searchOption = fromEnd ? NSStringCompareOptions.AnchoredSearch : NSStringCompareOptions.BackwardsSearch
        if caseInsensitive {
            searchOption.insert(NSStringCompareOptions.CaseInsensitiveSearch)
        }
        if let range = self.rangeOfString(subString, options: searchOption) where !range.isEmpty {
            return self.startIndex.distanceTo(range.startIndex)
        }
        return -1
    }
    
    /// Returns the first index of the occurency of the character in String
    public func indexOf(char: Character) -> Int? {
        for (index, c) in characters.enumerate() {
            if c == char {
                return index
            }
        }
        return nil
    }

}