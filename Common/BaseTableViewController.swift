//
//  BaseTableViewController.swift
//  iOSBaseProject
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

let kPageSize = 5;
typealias refreshCallBack = ()->Void ;

class BaseTableViewController: UITableViewController {

    var pageNumber = 1;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.whiteColor()
    }
    
    func createRefreshHeaderWithCallback(callBack: refreshCallBack) -> Void {
        
    }
    
    func createRefreshFooterWithCallback(callBack: refreshCallBack) -> Void {
        
    }
    
    func noMoreInfoAction() -> Void {
        if #available(iOS 8.0, *) {
            let alert = UIAlertController.init(title: "没有更多信息了", message: nil, preferredStyle: .Alert)
            let cancelAction = UIAlertAction.init(title: "知道了", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            UIAlertView.init(title: "没有更多信息了", message: nil, delegate: nil, cancelButtonTitle: "知道了").show()
        }
    }
}
