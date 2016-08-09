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
        self.showAlertView("没有更多信息了", cancelButtonTitle:"知道了")
    }
}
