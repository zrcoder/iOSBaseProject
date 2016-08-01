//
//  UIAlertView+block.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

extension UIAlertView {
    
    /**
     - parameter buttonTappedHandler: The index of buttons will ordered like : destructive button -> cancel button -> other buttons
     */
    public static func show(title: String? = nil,
                            message: String? = nil,
                            cancelButtonTitle: String? = nil,
                            otherButtonTitles: [String]? = nil,
                            buttonTappedHandler: AlertButtonTappedBlock? = nil) {
        
        let alertView = UIAlertView(title: title,
                                    message:message,
                                    delegate:AlertHelper.sharedHelper,
                                    cancelButtonTitle:cancelButtonTitle)
        
        if let otherButtonTitles = otherButtonTitles {
            for title in otherButtonTitles {
                alertView.addButtonWithTitle(title)
            }
        }
        
        alertButtonTappedHandler = buttonTappedHandler
        alertView.show()
        
    }
}
  