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

class Http {
    
    private class var host : String {
        get {
            #if DEBUG
            return "http://www.test.com"
            #else
            return "http://www.normal.com"
            #endif
        }
    }
    
    
    /**
     Http request
     - parameter method:     GET, POST and so on
     - parameter path:       can be by parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
     - parameter params:     can be nil
     - parameter completion: if failed, error will be a hint message and data will be nil
     */
    class func request(method:HttpMethod, path:String, parameters:Dictionary<String,AnyObject>?, completion:(error:String?, data:Dictionary<String, AnyObject>?)->Void) {

        if let url = NSURL(string: host + path) {
            
            // You can implement with Apple's native api such as NSURLSession or some third library such as Alamofire
            
            dLog()
            
            //  1.  Used Apple's native api here
            
            let request = NSMutableURLRequest(URL: url)
            request.timeoutInterval = 30
            request.cachePolicy = .ReturnCacheDataElseLoad
            
            switch method {
            case .POST:
                request.HTTPMethod = "POST"
            default:
                request.HTTPMethod = "GET"
            }
            
            if let parData = dataWithJSON(parameters) {
                request.HTTPBody = parData
            }
            
            log(request)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
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
            
            //  2.  Here is an implement example of Alamofire
            
            //        var alamofireMethod : Alamofire.Method
            //        switch method {
            //        case .POST:
            //            alamofireMethod = .POST
            //        default:
            //            alamofireMethod = .GET
            //        }
            //
            //        let url = host + path
            //        Alamofire.request(alamofireMethod, url, parameters: params)
            //            .responseJSON { response in
            //
            //                dLog(response.request)
            //
            //                switch response.result {
            //                case.Success(let json):
            //                    log("json type : \(json.dynamicType)")
            //                    let dict = json as? Dictionary<String,AnyObject>
            //                    completion(error: nil, data: dict)
            //                case.Failure(let error):
            //                    log(error.description)
            //                    completion(error: error.description, data: nil)
            //                }
            //        }
            
        }
    }
}


