//
//  ViewController.swift
//  iOSBaseProject
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dLog("Hello, world!")
        
        let array = [5, 9, 4, 2, 8]
        
        for _ in 1...100 {
            log(array[2...3].randomItem)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

