//
//  Http.swift
//  iOSBaseProject
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import Foundation

/**
 HTTP method definitions.
 */
public enum HttpMethod: String {
    case GET, POST
}


public struct Http {
    
    /// default host
    static var host: String {
        if isDebug {
            return "https://www.test.com"
        }
        return "https://www.normal.com"
    }
    
    /**
     Http request
     - parameter method:     GET, POST and so on
     - parameter host:       host
     - parameter path:       can be connected by parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
     - parameter parameters: can be nil
     - parameter timeout:    default is 30 seconds
     - parameter completion: if failed, data will be nil and error be generated
     */
    public static func request(method:HttpMethod = .GET,
                       host:String = host,
                       path:String,
                       parameters:[String : AnyObject]? = nil,
                       timeout: NSTimeInterval = 30,
                       completion:(error:NSError?, data:[String : AnyObject]?)->Void) {
        
        request(method, absolutePath: host + path, parameters: parameters, completion: completion)
    }
    
    /**
     Http request
     - parameter method:       GET, POST and so on
     - parameter absolutePath: host + path
     - parameter parameters:   can be nil
     - parameter timeout:      default is 30 seconds
     - parameter completion:   if failed, error will be a hint message and data will be nil
     */
    public static func request(method:HttpMethod = .GET,
                               absolutePath:String,
                               parameters:[String : AnyObject]? = nil,
                               timeout: NSTimeInterval = 30,
                               completion:(error:NSError?, data:[String : AnyObject]?)->Void) {
        
        if let url = NSURL(string: absolutePath) {
            
            // You can implement with Apple's native api such as NSURLSession or some third library such as Alamofire
            
            //  Used Apple's native api here
            
            let request = NSMutableURLRequest(URL: url)
            request.timeoutInterval = timeout
            request.HTTPMethod = method.rawValue;
            if let parData = dataWithJSON(parameters) {
                request.HTTPBody = parData
            }
            
            dLog(combinedString(absolutePath, parameters: parameters))
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (let data, let response, let error) in
                dispatch_async(dispatch_get_main_queue()) {
                    guard let _:NSData = data, let _:NSURLResponse = response where error == nil else {
                        completion(error: error, data: nil)
                        return
                    }
                    
                    if let dictionary = JSONWithData(data) {
                        completion(error: nil, data: dictionary as? [String : AnyObject])
                    } else {
                        let hint = "can't parse response data -> dictionary"
                        let error = NSError(domain: hint, code: -2, userInfo: nil)
                        completion(error: error, data: nil)
                    }
                }
            }
            task.resume()
            
        } else {
            let error = NSError(domain: "url error", code: -1, userInfo: nil);
            completion(error: error, data: nil)
        }
    }
}

/**
 Combine URL and parameters as a String
 - parameter URLString:  e.g. "https://www.test.com"
 - parameter parameters: e.g. ["key": "value"]
 - returns: e.g. "https://www.test.com?key=value"
 */
public func combinedString(URLString: String, parameters: [String: AnyObject]?) -> String {
    let parString = stringWithJSON(parameters)
    var urlString = URLString
    if urlString.hasSuffix("/") {
        urlString = urlString[0...urlString.length - 2]
    }
    if parString == nil {
        return URLString
    }
    var parStr = parString!
    var result = URLString
    result.append("?" as Character)
    if parStr.hasPrefix("{") {
        parStr = parStr[1...parStr.length-1]
    }
    if parStr.hasSuffix("}") {
        parStr = parStr[0...parStr.length-2]
    }
    parStr = parStr.stringByReplacingOccurrencesOfString(":", withString: "=")
    parStr = parStr.stringByReplacingOccurrencesOfString(",", withString: "&")
    parStr = parStr.stringByReplacingOccurrencesOfString("\"", withString: "")
    result.appendContentsOf(parStr)
    return result
}

