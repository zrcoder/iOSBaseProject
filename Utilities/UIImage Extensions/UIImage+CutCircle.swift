//
//  UIImage+CutCircle.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/24.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func circleImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        CGContextAddEllipseInRect(context, rect)
        CGContextClip(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
