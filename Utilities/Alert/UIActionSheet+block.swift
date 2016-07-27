//
//  UIActionSheet+block.swift
//  AlertHelper-Swift
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

extension UIActionSheet {
    public static func showIn(view: UIView,
                       title: String?,
                       destructiveTitle: String?,
                       cancelButtonTitle: String?,
                       otherButtonTitles: [String]?,
                       buttonTappedHandler: AlertButtonTappedBlock) {
        let actionSheet = UIActionSheet(title: title, delegate: UIApplication.sharedApplication(), cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveTitle)
        
        for title in otherButtonTitles! {
            actionSheet.addButtonWithTitle(title)
        }
        alertButtonTappedHandler = buttonTappedHandler
        actionSheet.showInView(view)
    }
}
