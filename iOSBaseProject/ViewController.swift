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
        log(DeviceHelper.cpuNumber())
        Http.request(.GET, absolutePath: "hhh", parameters: nil) { (error, data) in
            if let error = error {
                log(error)
            } else {
                log(data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

