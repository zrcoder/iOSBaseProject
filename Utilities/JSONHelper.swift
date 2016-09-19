//
//  JSONHelper.swift
//  iOSBaseProject
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

/**
 Parse JSON (Array, Dictionary...) to NSData
 */
public func dataWithJSON(_ object:AnyObject?) -> Data? {
    if let object = object {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions())
            return data
        } catch let error as NSError {
            dLog("JSON->NSData failed:\(error)")
        }
    }
    return nil
}

/**
 Parse NSData to JSON (Array, Dictionary...)
 */
public func JSONWithData(_ data:Data?) -> AnyObject? {
    if let data = data {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return object as AnyObject?
        } catch let error as NSError {
            dLog("NSData->JSON failed:\(error)")
        }
        
    }
    return nil
}

/**
 Parse NSData to String
 */
public func stringWithData(_ data:Data?) -> String? {
    if let data = data {
        return String(data: data, encoding: String.Encoding.utf8)
    }
    return nil
}

/**
 Parse String to NSData
 */
public func dataWithString(_ string:String?) -> Data? {
    if let string = string {
        return string.data(using: String.Encoding.utf8)
    }
    return nil
}

/**
 Parse NSString to JSON (Array, Dictionary...)
 */
public func JSONWithString(_ string:String?) -> AnyObject? {
    let data = dataWithString(string)
    return JSONWithData(data)
}

/**
 Parse JSON (Array, Dictionary...) to String
 */
public func stringWithJSON(_ object:AnyObject?) -> String? {
    let data = dataWithJSON(object)
    return stringWithData(data)
}
