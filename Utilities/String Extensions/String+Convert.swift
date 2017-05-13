//
//  String+Convert.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

// MARK: - Carvert to Int, Double, Float, Bool, ...
public extension String {
    
    /// Converts String to Int
    public func toInt() -> Int? {
        if let num = toNumber() {
            return num.intValue
        }
        return nil
    }
    
    /// Converts String to Double
    public func toDouble() -> Double? {
        if let num = toNumber()  {
            return num.doubleValue
        }
        return nil
    }
    
    /// Converts String to Float
    public func toFloat() -> Float? {
        if let num = toNumber() {
            return num.floatValue
        }
        return nil
    }
    
    /// Converts String to Bool
    public func toBool() -> Bool? {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
        if trimmed == "true" {
            return true
        }
        if trimmed == "false" {
            return false
        }
        return nil
    }
    
    private func toNumber() -> NSNumber? {
        return NumberFormatter().number(from: self)
    }

}
