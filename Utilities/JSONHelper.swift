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
public func dataWithJSON(object:AnyObject?) -> NSData? {
    if let object = object {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions())
            return data
        } catch {
            dLog("parse JSONObject -> NSData failed")
        }
    }
    return nil
}
/**
 Parse NSData to JSON (Array, Dictionary...)
 */
public func JSONWithData(data:NSData?) -> AnyObject? {
    if let data = data {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            return object
        } catch {
            dLog("parse NSData -> JSONObject failed")
        }
        
    }
    return nil
}

/**
 Parse NSData to String
 */
public func stringWithData(data:NSData?) -> String? {
    if let data = data {
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    return nil
}
/**
 Parse String to NSData
 */
public func dataWithString(string:String?) -> NSData? {
    if let string = string {
        return string.dataUsingEncoding(NSUTF8StringEncoding)
    }
    return nil
}

/**
 Parse NSString to JSON (Array, Dictionary...)
 */
public func JSONWithString(string:String?) -> AnyObject? {
    let data = dataWithString(string)
    return JSONWithData(data)
}
/**
 Parse JSON (Array, Dictionary...) to String
 */
public func stringWithJSON(object:AnyObject?) -> String? {
    let data = dataWithJSON(object)
    return stringWithData(data)
}
