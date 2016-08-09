//
//  String+Case.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

// MARK: - upercase, lowercase
extension String {
    
    /// Capitalizes first character of String
    public mutating func capitalizeFirst() {
        guard characters.count > 0 else { return }
        self.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
    }
    
    /// Capitalizes first character of String, returns a new string
    public func capitalizedFirst() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
        return result
    }
    
    /// Uppercases first 'count' characters of String
    public mutating func uppercasePrefix(count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceRange(startIndex..<startIndex.advancedBy(min(count, characters.count)),
                          with: String(self[startIndex..<startIndex.advancedBy(min(count, characters.count))]).uppercaseString)
    }
    
    /// Uppercases first 'count' characters of String, returns a new string
    public func uppercasedPrefix(count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceRange(startIndex..<startIndex.advancedBy(min(count, characters.count)),
                            with: String(self[startIndex..<startIndex.advancedBy(min(count, characters.count))]).uppercaseString)
        return result
    }
    
    /// Uppercases last 'count' characters of String
    public mutating func uppercaseSuffix(count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceRange(endIndex.advancedBy(-min(count, characters.count))..<endIndex,
                          with: String(self[endIndex.advancedBy(-min(count, characters.count))..<endIndex]).uppercaseString)
    }
    
    /// Uppercases last 'count' characters of String, returns a new string
    public func uppercasedSuffix(count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceRange(endIndex.advancedBy(-min(count, characters.count))..<endIndex,
                            with: String(self[endIndex.advancedBy(-min(count, characters.count))..<endIndex]).uppercaseString)
        return result
    }
    
    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex)
    public mutating func uppercase(range range: Range<Int>) {
        let from = max(range.startIndex, 0), to = min(range.endIndex, characters.count)
        guard characters.count > 0 && (0..<characters.count).contains(from) else { return }
        self.replaceRange(startIndex.advancedBy(from)..<startIndex.advancedBy(to),
                          with: String(self[startIndex.advancedBy(from)..<startIndex.advancedBy(to)]).uppercaseString)
    }
    
    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    public func uppercased(range range: Range<Int>) -> String {
        let from = max(range.startIndex, 0), to = min(range.endIndex, characters.count)
        guard characters.count > 0 && (0..<characters.count).contains(from) else { return self }
        var result = self
        result.replaceRange(startIndex.advancedBy(from)..<startIndex.advancedBy(to),
                            with: String(self[startIndex.advancedBy(from)..<startIndex.advancedBy(to)]).uppercaseString)
        return result
    }
    
    /// Lowercases first character of String
    public mutating func lowercaseFirst() {
        guard characters.count > 0 else { return }
        self.replaceRange(startIndex...startIndex, with: String(self[startIndex]).lowercaseString)
    }
    
    /// Lowercases first character of String, returns a new string
    public func lowercasedFirst() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).lowercaseString)
        return result
    }
    
    /// Lowercases first 'count' characters of String
    public mutating func lowercasePrefix(count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceRange(startIndex..<startIndex.advancedBy(min(count, characters.count)),
                          with: String(self[startIndex..<startIndex.advancedBy(min(count, characters.count))]).lowercaseString)
    }
    
    /// Lowercases first 'count' characters of String, returns a new string
    public func lowercasedPrefix(count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceRange(startIndex..<startIndex.advancedBy(min(count, characters.count)),
                            with: String(self[startIndex..<startIndex.advancedBy(min(count, characters.count))]).lowercaseString)
        return result
    }
    
    /// Lowercases last 'count' characters of String
    public mutating func lowercaseSuffix(count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceRange(endIndex.advancedBy(-min(count, characters.count))..<endIndex,
                          with: String(self[endIndex.advancedBy(-min(count, characters.count))..<endIndex]).lowercaseString)
    }
    
    /// Lowercases last 'count' characters of String, returns a new string
    public func lowercasedSuffix(count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceRange(endIndex.advancedBy(-min(count, characters.count))..<endIndex,
                            with: String(self[endIndex.advancedBy(-min(count, characters.count))..<endIndex]).lowercaseString)
        return result
    }
    
    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex)
    public mutating func lowercase(range range: Range<Int>) {
        let from = max(range.startIndex, 0), to = min(range.endIndex, characters.count)
        guard characters.count > 0 && (0..<characters.count).contains(from) else { return }
        self.replaceRange(startIndex.advancedBy(from)..<startIndex.advancedBy(to),
                          with: String(self[startIndex.advancedBy(from)..<startIndex.advancedBy(to)]).lowercaseString)
    }
    
    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    public func lowercased(range range: Range<Int>) -> String {
        let from = max(range.startIndex, 0), to = min(range.endIndex, characters.count)
        guard characters.count > 0 && (0..<characters.count).contains(from) else { return self }
        var result = self
        result.replaceRange(startIndex.advancedBy(from)..<startIndex.advancedBy(to),
                            with: String(self[startIndex.advancedBy(from)..<startIndex.advancedBy(to)]).lowercaseString)
        return result
    }
}
