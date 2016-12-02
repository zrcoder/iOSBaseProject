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
        
        let button = UIButton(frame: CGRect(x: 0, y: 64, width: 50000, height: 60))
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func test() {
        let v = UIView(frame: CGRect(x: 0, y: 400, width: 10, height: 10))
        v.backgroundColor = UIColor.red
        view.addSubview(v)
        let fromPoint = v.frame.origin
        let toPoint = CGPoint(x: 400, y: 200)
        
        let controlPoint = CGPoint(x: (fromPoint.x + toPoint.x) * 0.5, y: min(fromPoint.y, toPoint.y) - 20)
        
        v.bezierMove(to: toPoint, control: controlPoint, duration: 1)
    }

}

