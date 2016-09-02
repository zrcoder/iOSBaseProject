//
//  BaseViewController.swift
//  iOSBaseProject
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

//  BaseViewController should be super class of most viewControllers in project
//  we define general appearences and implement some important methods here

class BaseViewController: UIViewController {
    
    // Mark: Some methods will be used frequently
    
    
    // Mark:Some methods can be overridden
    func backButtonTapped() -> Void {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.whiteColor()
        
        //custom back button. --if you want more customs, see BaseNavigationController.swift
        if let viewControllers = navigationController?.viewControllers {
            if viewControllers.count > 0 && self != viewControllers[0] {
                navigationItem.leftBarButtonItems = leftBarButtonItems
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private var leftBarButtonItems: [UIBarButtonItem] {
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 44, 44)
        button.setImage(UIImage(named: BaseStyle.backButtonImageName), forState: .Normal)
        button.addTarget(self, action: #selector(backButtonTapped), forControlEvents: .TouchUpInside)
        let buttonItem = UIBarButtonItem(customView: button)
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spacerItem.width = -18;
        return [spacerItem, buttonItem]
    }
    
}
