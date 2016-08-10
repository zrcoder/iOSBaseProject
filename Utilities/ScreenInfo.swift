//
//  ScreenInfo.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

/// Size of the main screen
public var screenSize: CGSize {
    return UIScreen.mainScreen().bounds.size
}

/// Width of the main screen
public var screenWidth: CGFloat {
    return screenSize.width
}

/// Height of the main screen
public var screenHeight: CGFloat {
    return screenSize.height
}

/// Heitht of the status bar
public var statusBarHeight: CGFloat {
    return UIApplication.sharedApplication().statusBarFrame.height
}