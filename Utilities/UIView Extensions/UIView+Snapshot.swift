//
//  UIView+Snapshot.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public extension UIView {
    public var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.renderInContext(context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil        
    }
}
