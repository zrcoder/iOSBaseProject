//
//  BaseViewController.swift
//  iOSProjectBase
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

//  BaseViewController should be super class of most viewControllers in project
//  we define general appearences and implement some important method here

class BaseViewController: UIViewController {
    
    // Some methods will be used frequently
    
    /**
     show aleart to dial a number
     
     - parameter number: the number you want to dial
     */
    func alertToDialNumber(number : String?) {
        if let phone = number {
            let string = "tel:" + phone
            dialWebView.loadRequest(NSURLRequest(URL: NSURL(string: string)!))
        }
    }
    private let dialWebView  = UIWebView()
    
    
    // Some methods can be overrided
    func popBack() -> Void {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //custom some appearences like navigation bar and so no
        
        if self != self.navigationController?.viewControllers[0] {
            let button = UIButton(type: .Custom)
            button.frame = CGRectMake(0, 0, 44, 44)
            button.setImage(UIImage(named: "arrowLeft"), forState: .Normal)
            button.addTarget(self, action: #selector(popBack), forControlEvents: .TouchUpInside)
            let buttonItem = UIBarButtonItem(customView: button)
            let spacerItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
            spacerItem.width = -18;
            navigationItem.leftBarButtonItems = [spacerItem, buttonItem]
            
        }
        
        let titleAttributes = [NSForegroundColorAttributeName:UIColor(hex:0x474747),
                               NSFontAttributeName:UIFont.systemFontOfSize(15)]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(hex:0xbbeebb), size: CGSizeMake(screenWidth, 64)), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = imageWithColor(UIColor.clearColor(), size: CGSizeMake(screenWidth, 1))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
