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

/// default host
#if DEBUG
let host = "http://www.test.com"
#else
let host = "https://www.normal.com"
#endif

public struct Http {
    
    /**
     Http request
     - parameter method:     GET, POST and so on
     - parameter path:       can be connected by parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
     - parameter params:     can be nil
     - parameter completion: if failed, error will be a hint message and data will be nil
     */
    public static func request(method:HttpMethod,
                       path:String,
                       parameters:[String : AnyObject]?,
                       completion:(error:NSError?, data:[String : AnyObject]?)->Void) {
        
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
    public static func request(method:HttpMethod,
                       host:String,
                       path:String,
                       parameters:[String : AnyObject]?,
                       completion:(error:NSError?, data:[String : AnyObject]?)->Void) {
        
        request(method, absolutePath: host + path, parameters: parameters, completion: completion)
    }
    
    /**
     Http request
     - parameter method:       GET, POST and so on
     - parameter absolutePath: host + path
     - parameter parameters:   can be nil
     - parameter completion:   if failed, error will be a hint message and data will be nil
     */
    public static func request(method:HttpMethod,
                               absolutePath:String,
                               parameters:[String : AnyObject]?,
                               completion:(error:NSError?, data:[String : AnyObject]?)->Void) {
        
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


