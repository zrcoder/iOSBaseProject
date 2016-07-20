//
//  AlertHelper.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

typealias AlertButtonTappedBlock = (Int) -> Void;
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

/**
 Show an alert view with a call back block
 If the system version < 8.0, we will use UIAlertView , otherwise, UIAlertController
 - parameter viewController:
 - parameter title:
 - parameter message:
 - parameter destructiveButtonTitle: If the system version < 8.0, this parameter will lose effictiveness
 - parameter cancelButtonTitle:
 - parameter otherButtonTitles:
 - parameter buttonTappedHandler:    The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
func showAlertViewFor(viewController: UIViewController?,
                      title: String?,
                      message: String?,
                      destructiveButtonTitle: String?,
                      cancelButtonTitle: String?,
                      otherButtonTitles: [String]?,
                      buttonTappedHandler: AlertButtonTappedBlock) {
    if #available(iOS 8.0, *) {
        if let viewController = viewController {
            UIAlertController.show(viewController: viewController, title: title, message: message, destructiveButtonTitle: destructiveButtonTitle, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, buttonTappedHandler: buttonTappedHandler)
        }
    } else {
        UIAlertView.show(title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, buttonTappedHandler: buttonTappedHandler)
    }
}

/**
 Show an action sheet with a call back block
 If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
 - parameter viewController:
 - parameter sourceRect:             If is nil, the action sheet will be displayed from bottom of viewController's view
 - parameter title:
 - parameter message:                If the system version < 8.0, this parameter will lose effictiveness
 - parameter destructiveButtonTitle:
 - parameter cancelButtonTitle:      If the device ia iPad, cancel button will invisible, but it exist as a blanck button around the action sheet
 - parameter otherButtonTitles:
 - parameter buttonTappedHandler:    The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
func showActionSheetFor(viewController: UIViewController?,
                        sourceRect: CGRect? = nil,
                        title: String?,
                        message: String?,
                        destructiveButtonTitle: String?,
                        cancelButtonTitle: String?,
                        otherButtonTitles: [String]?,
                        buttonTappedHandler: AlertButtonTappedBlock) {
    if let viewController = viewController {
        if #available(iOS 8.0, *) {
            UIAlertController.show(.ActionSheet, viewController: viewController, sourceRect: sourceRect, title: title, message: message, destructiveButtonTitle: destructiveButtonTitle, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, buttonTappedHandler: buttonTappedHandler)
        } else {
            UIActionSheet.showIn(viewController.view, title: title, destructiveTitle: destructiveButtonTitle, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, buttonTappedHandler: buttonTappedHandler)
        }
    }
}