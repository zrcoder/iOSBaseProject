//
//  UIAlertView+block.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

extension UIAlertView {
    static func show(title: String?,
                     message: String?,
                     cancelButtonTitle: String?,
                     otherButtonTitles: [String]?,
                     buttonTappedHandler: AlertButtonTappedBlock) {        
        
        let alertView = UIAlertView(title: title, message:message, delegate:UIApplication.sharedApplication(), cancelButtonTitle:cancelButtonTitle)
        for title in otherButtonTitles! {
            alertView.addButtonWithTitle(title)
        }
        alertButtonTappedHandler = buttonTappedHandler
        alertView.show()
    }
}
  