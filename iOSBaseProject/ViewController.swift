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
        run(after: 2.5) {
            log("Glad to see you again!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

