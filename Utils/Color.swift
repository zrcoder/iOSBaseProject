//
//  Color.swift
//  iOSSwiftProjectFrame
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif

#if os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
#elseif os(OSX)
  public typealias Color = NSColor
#endif

public extension Color {

  /**
   Creates a color from an hex string (e.g. "#3498db").
   If the given hex string is invalid the initialiser will create a black color.
   - parameter hexString: A hexa-decimal color string representation.
   */
  public convenience init(hexString: String) {
    let hexString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let scanner   = NSScanner(string: hexString)

    if (hexString.hasPrefix("#")) {
      scanner.scanLocation = 1
    }

    var color: UInt32 = 0

    if scanner.scanHexInt(&color) {
      self.init(hex: color)
    } else {
      self.init(hex: 0x000000)
    }
  }

  /**
   Creates a color from an hex integer (e.g. 0x3498db).     
   - parameter hex: A hexa-decimal UInt32 that represents a color.
   */
  public convenience init(hex: UInt32) {
    let mask = 0x000000FF

    let r = Int(hex >> 16) & mask
    let g = Int(hex >> 8) & mask
    let b = Int(hex) & mask

    let red   = CGFloat(r) / 255
    let green = CGFloat(g) / 255
    let blue  = CGFloat(b) / 255

    self.init(red:red, green:green, blue:blue, alpha:1)
  }
}



