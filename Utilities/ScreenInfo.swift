//
//  ScreenInfo.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public var screenSize: CGSize {
    return UIScreen.mainScreen().bounds.size
}
public var screenWidth: CGFloat {
    return screenSize.width
}
public var screenHeight: CGFloat {
    return screenSize.height
}

public var statusBarHeight: CGFloat {
    return UIApplication.sharedApplication().statusBarFrame.height
}