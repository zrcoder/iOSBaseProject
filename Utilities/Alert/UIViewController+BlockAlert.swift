//
//  UIViewController+BlockAlert.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/28.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     Show an alert view with a call back block
     If the system version < 8.0, we will use UIAlertView , otherwise, UIAlertController
     - parameter title:
     - parameter message:
     - parameter destructiveButtonTitle: If the system version < 8.0, this parameter will lose effictiveness
     - parameter cancelButtonTitle:
     - parameter otherButtonTitles:
     - parameter buttonTappedHandler:    The index of buttons will ordered like : destructive button -> cancel button -> other buttons
     */
    public func showAlertView(title: String? = nil,
                              message: String? = nil,
                              destructiveButtonTitle: String? = nil,
                              cancelButtonTitle: String? = nil,
                              otherButtonTitles: [String]? = nil,
                              buttonTappedHandler: AlertButtonTappedBlock? = nil) {
        
        if #available(iOS 8.0, *) {
            UIAlertController.show(viewController: self,
                                   title: title,
                                   message: message,
                                   destructiveButtonTitle: destructiveButtonTitle,
                                   cancelButtonTitle: cancelButtonTitle,
                                   otherButtonTitles: otherButtonTitles,
                                   buttonTappedHandler: buttonTappedHandler)
        } else {
            UIAlertView.show(title,
                             message: message,
                             cancelButtonTitle: cancelButtonTitle,
                             otherButtonTitles: otherButtonTitles,
                             buttonTappedHandler: buttonTappedHandler)
        }
        
    }
    
    /**
     Show an action sheet with a call back block
     If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
     - parameter title:
     - parameter message:                If the system version < 8.0, this parameter will lose effictiveness
     - parameter destructiveButtonTitle:
     - parameter cancelButtonTitle:      If the device ia iPad, cancel button will invisible, but it exist as a blanck button around the action sheet
     - parameter otherButtonTitles:
     - parameter sourceRect:             If is nil, the action sheet will be displayed from bottom of viewController's view
     - parameter buttonTappedHandler:    The index of buttons will ordered like : destructive button -> cancel button -> other buttons
     */
    public func showActionSheet(title: String? = nil,
                                message: String? = nil,
                                destructiveButtonTitle: String? = nil,
                                cancelButtonTitle: String? = nil,
                                otherButtonTitles: [String]? = nil,
                                sourceRect: CGRect? = nil,
                                buttonTappedHandler: AlertButtonTappedBlock? = nil) {
        
        if #available(iOS 8.0, *) {
            UIAlertController.show(.ActionSheet,
                                   viewController: self,
                                   sourceRect: sourceRect,
                                   title: title,
                                   message: message,
                                   destructiveButtonTitle: destructiveButtonTitle,
                                   cancelButtonTitle: cancelButtonTitle,
                                   otherButtonTitles: otherButtonTitles,
                                   buttonTappedHandler: buttonTappedHandler)
        } else {
            UIActionSheet.showIn(self.view,
                                 title: title,
                                 destructiveTitle: destructiveButtonTitle,
                                 cancelButtonTitle: cancelButtonTitle,
                                 otherButtonTitles: otherButtonTitles,
                                 buttonTappedHandler: buttonTappedHandler)
        }
        
    }
    
}