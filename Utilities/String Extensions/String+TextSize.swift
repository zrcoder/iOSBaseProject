//
//  String+TextSize.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public extension String {
    /// Returns hight of rendered string
    public func height(width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attributes: [String: AnyObject] = [NSFontAttributeName: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attributes.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        }
        let size = CGSize(width: width, height: CGFloat(DBL_MAX))
        return ceil((self as NSString).boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:attributes, context: nil).height)
    }

}