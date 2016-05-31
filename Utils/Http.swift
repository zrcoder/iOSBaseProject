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
    case GET = "GET"
    case POST = "POST"
}

class Http {
    /// default host
    private class var host : String {
        get {
            #if DEBUG
                return "http://www.test.com"
            #else
                return "https://www.normal.com"
            #endif
        }
    }
    
    /**
     Http request
     - parameter method:     GET, POST and so on
     - parameter path:       can be connected by parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
     - parameter params:     can be nil
     - parameter completion: if failed, error will be a hint message and data will be nil
     */
    class func request(method:HttpMethod,
                       path:String,
                       parameters:Dictionary<String,AnyObject>?,
                       completion:(error:String?, data:Dictionary<String, AnyObject>?)->Void) {
        
        request(method, absolutePath: host + path, parameters: parameters, completion: completion)
    }
    
    /**
     Http request
     - parameter method:     GET, POST and so on
     - parameter host:       host
     - parameter path:       can be connected by parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
     - parameter parameters: can be nil
     - parameter completion: if failed, error will be a hint message and data will be nil
     */
    class func request(method:HttpMethod,
                       host:String,
                       path:String,
                       parameters:Dictionary<String,AnyObject>?,
                       completion:(error:String?, data:Dictionary<String, AnyObject>?)->Void) {
        request(method, absolutePath: host + path, parameters: parameters, completion: completion)
    }
    
    /**
     Http request
     - parameter method:       GET, POST and so on
     - parameter absolutePath: host + path
     - parameter parameters:   can be nil
     - parameter completion:   if failed, error will be a hint message and data will be nil
     */
    class func request(method:HttpMethod,
                               absolutePath:String,
                               parameters:Dictionary<String,AnyObject>?,
                               completion:(error:String?, data:Dictionary<String, AnyObject>?)->Void) {
        
        if let url = NSURL(string: absolutePath) {
            
            // You can implement with Apple's native api such as NSURLSession or some third library such as Alamofire
            
            //  Used Apple's native api here
            
            let request = NSMutableURLRequest(URL: url)
            request.timeoutInterval = 30
            request.cachePolicy = .ReturnCacheDataElseLoad
            request.HTTPMethod = method.rawValue;
            if let parData = dataWithJSON(parameters) {
                request.HTTPBody = parData
            }
            dLog(request)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response where error == nil else {
                    log(error?.description)
                    completion(error: String(error?.code), data: nil)
                    return
                }
                
                if let dictionary = JSONWithData(data) {
                    completion(error: nil, data: dictionary as? Dictionary<String, AnyObject>)
                } else {
                    let hint = "parse response data -> dictionary error"
                    completion(error: hint, data: nil)
                }
            }
            task.resume()
            
        } else {
            completion(error: "URL Error", data: nil)
        }
    }

}


