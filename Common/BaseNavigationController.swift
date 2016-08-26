//
//  BaseNavigationController.swift
//  iOSBaseProject
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

/// A UINavigationController subclass allowing the interactive pop gesture to be recognized when the navigation bar is hidden or a custom back button is used.
// We can also custom appearance of the navigation bar in the impletion file(BaseNavigationController.m).
// Thanks for the idea goes to https://github.com/fastred/AHKNavigationController

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if delegate == nil {
            delegate = self
        }
        interactivePopGestureRecognizer?.delegate = self
        
        
        // Mark: custom the navigation bar
        // (It's better to custom the back button in BaseViewController, because you can override the button action in a single view controller. --see BaseViewController.swift)
        
        // Title
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color(hex:0x474747), NSFontAttributeName: UIFont.systemFontOfSize(15)]
        // Background and bottom line
        navigationBar.setBackgroundImage(imageWithColor(Color(hex: 0xbbeebb), size: CGSize(width: screenWidth, height: 64)), forBarMetrics: .Default)
        navigationBar.shadowImage = imageWithColor(Color.clearColor(), size: CGSize(width: screenWidth, height: 1))
    }
    
    // Mark: UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if interactivePopGestureRecognizer != nil {
            if let delegate = interactivePopGestureRecognizer!.delegate {
                assert(delegate === self, "BaseNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.")
            }
        }
        duringPushAnimation = false
        realDelegate?.navigationController?(navigationController, didShowViewController: viewController, animated: animated)
    }
    
    // Mark: UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == interactivePopGestureRecognizer) {
            return viewControllers.count > 1 && !duringPushAnimation
        }
        return true
    }
    
    private var duringPushAnimation = false
    private var realDelegate: UINavigationControllerDelegate?
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }

}
