//
//  AlertHelper.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/28.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public typealias AlertButtonTappedBlock = (Int) -> Void;
var alertButtonTappedHandler: AlertButtonTappedBlock?

extension UIApplication: UIAlertViewDelegate, UIActionSheetDelegate {
    
    public func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if let handler = alertButtonTappedHandler {
            handler(buttonIndex)
            alertButtonTappedHandler = nil
        }
    }
    
    public func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let handler = alertButtonTappedHandler {
            handler(buttonIndex)
            alertButtonTappedHandler = nil
        }
    }

}

