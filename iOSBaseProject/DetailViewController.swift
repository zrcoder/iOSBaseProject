//
//  DetailViewController.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func backButtonTapped() {
        let _ = navigationController?.popToRootViewController(animated: true)
    }

}
