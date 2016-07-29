//
//  UIAlertCotroller+block.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
extension UIAlertController {
    
    public static func show(style: UIAlertControllerStyle = .Alert,
                            viewController: UIViewController,
                            sourceRect: CGRect? = nil,
                            title: String? = nil,
                            message: String? = nil,
                            destructiveButtonTitle: String? = nil,
                            cancelButtonTitle: String? = nil,
                            otherButtonTitles: [String]? = nil,
                            buttonTappedHandler: AlertButtonTappedBlock? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let destructiveButtonTitle = destructiveButtonTitle {
            let action = UIAlertAction(title: destructiveButtonTitle, style: .Destructive, handler: { (UIAlertAction) in
                buttonTappedHandler?(0)
            })
            alertController.addAction(action)
        }
        
        if let cancelButtonTitle = cancelButtonTitle {
            let action = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler: { (UIAlertAction) in
                if destructiveButtonTitle != nil {
                    buttonTappedHandler?(1)
                } else {
                    buttonTappedHandler?(0)
                }
            })
            alertController.addAction(action)
        }
        
        if let otherButtonTitles = otherButtonTitles {
            for (index, title) in otherButtonTitles.enumerate() {
                
                let action = UIAlertAction(title: title, style: .Default, handler: { (UIAlertAction) in
                    if destructiveButtonTitle != nil && cancelButtonTitle != nil {
                        buttonTappedHandler?(2 + index)
                    } else if destructiveButtonTitle == nil && cancelButtonTitle == nil {
                        buttonTappedHandler?(index)
                    } else {
                        buttonTappedHandler?(1 + index)
                    }
                })
                alertController.addAction(action)
            }
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = viewController.view
            if let sourceRect = sourceRect {
                popoverController.sourceRect = sourceRect
            } else {
                let size = viewController.view.bounds.size
                popoverController.sourceRect = CGRect(x: size.width/2, y: size.height - 2, width: 0, height: 2)
            }
        }
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
