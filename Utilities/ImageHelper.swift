//
//  ImageHelper.swift
//  iOSProjectBase
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

/**
 generate image with color
 - returns: the image size will be (1.0, 1.0)
 */
public func imageWithColor(color: UIColor) -> UIImage {
    return imageWithColor(color, size: CGSizeMake(1.0, 1.0))
}

/**
 generate image with color and size
 */
public func imageWithColor(color: UIColor, size:CGSize) -> UIImage {
    let rect = CGRectMake(0.0, 0.0, size.width, size.height)
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

/**
 Compress image
 */
public func imageFromSource(image : UIImage, compressedToWidth newWidth : CGFloat) -> UIImage {
    var height = image.size.height
    let width = image.size.width
    height = height * newWidth / width
    let newSize = CGSizeMake(newWidth, height)
    return imageFromSource(image, compressedToSize: newSize)
}

/**
 Compress image
 */
public func imageFromSource(image : UIImage, compressedToSize size : CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    image.drawInRect(CGRectMake(0.0, 0.0, size.width, size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}