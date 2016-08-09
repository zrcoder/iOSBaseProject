//
//  DeviceInfo.swift
//  iOSBaseProject
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

private let UniqueIdentifierDefaultsKey = "UniqueIdentifierDefaultsKey"

public struct DeviceInfo {
    /// Returns true if it's simulator and not a device
    public static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    /// Returns true if its on a device and not a simulator
    public static var isDevice: Bool {
        return !isSimulator
    }
    /**
     *  The system version without the subversion
     *  Example: 7.0
     */
    public static func systemVersion() -> String {
        return UIDevice.currentDevice().systemVersion as String
    }
    
    /**
     *  The device platform string
     *  Example: "iPhone3,2"
     */
    public static func platform() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: size, repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    /**
     *  The user-friendly device platform string
     *  Example: "iPad Air (Cellular)"
     */
    public static func platformForUser() -> String {
        let platform = self.platform()
        
        switch platform {
        //  iPhone
        case "iPhone1,1": return "iPhone 2G"
        case "iPhone1,2": return "iPhone 3G"
        case "iPhone2,1": return "iPhone 3GS"
        case "iPhone3,1": return "iPhone 4"
        case "iPhone3,3": return "iPhone 4 (CDMA)"
        case "iPhone4,1": return "iPhone 4S"
        case "iPhone5,1": return "iPhone 5 (GSM)"
        case "iPhone5,2": return "iPhone 5 (CDMA)"
        case "iPhone5,3": return "iPhone 5C (GSM)"
        case "iPhone5,4": return "iPhone 5C (Global)"
        case "iPhone6,1": return "iPhone 5S (GSM)"
        case "iPhone6,2": return "iPhone 5S (Global)"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        //  iPod
        case "iPod1,1": return "iPod Touch 1G"
        case "iPod2,1": return "iPod Touch 2G"
        case "iPod3,1": return "iPod Touch 3G"
        case "iPod4,1": return "iPod Touch 4G"
        case "iPod5,1": return "iPod Touch 5G"
        //  iPad
        case "iPad1,1": return "iPad 1"
        case "iPad2,1": return "iPad 2 (WiFi)"
        case "iPad2,2": return "iPad 2 (GSM)"
        case "iPad2,3": return "iPad 2 (CDMA)"
        case "iPad2,4": return "iPad 2 (32nm)"
        case "iPad2,5": return "iPad mini (WiFi)"
        case "iPad2,6": return "iPad mini (GSM)"
        case "iPad2,7": return "iPad mini (CDMA)"
        case "iPad3,1": return "iPad 3 (WiFi)"
        case "iPad3,2": return "iPad 3 (CDMA)"
        case "iPad3,3": return "iPad 3 (GSM)"
        case "iPad3,4": return "iPad 4 (WiFi)"
        case "iPad3,5": return "iPad 4 (GSM)"
        case "iPad3,6": return "iPad 4 (CDMA)"
        case "iPad4,1": return "iPad Air (WiFi)"
        case "iPad4,2": return "iPad Air (Cellular)"
        case "iPad4,3": return "iPad Air (China)"
        case "iPad4,4": return "iPad mini 2 (WiFi)"
        case "iPad4,5": return "iPad mini 2 (Cellular)"
        case "iPad4,6": return "iPad mini 2 (China)"
        case "iPad4,7": return "iPad mini 3 (WiFi)"
        case "iPad4,8": return "iPad mini 3 (Cellular)"
        case "iPad4,9": return "iPad mini 3 (China)"
        case "iPad5,3": return "iPad Air 2 (WiFi)"
        case "iPad5,4": return "iPad Air 2 (Cellular)"
        //  simulator
        case "i386": return "Simulator i386"
        case "x86_64": return "Simulator x86_64"
        default: return platform;
        }
    }
    /**
     *  Check if the current device is an iPhone
     */
    public static func isiPhone() -> Bool {
        return self.platform().hasPrefix("iPhone")
    }
    /**
     *  Check if the current device is an iPad
     */
    public static func isiPad() -> Bool {
        return self.platform().hasPrefix("iPad")
    }
    /**
     *  Check if the current device is an iPod
     */
    public static func isiPod() -> Bool {
        return self.platform().hasPrefix("iPod")
    }
    /**
     *  Check if the current device has a Retina display
     */
    public static func isRetina() -> Bool {
        let screen = UIScreen.mainScreen()
        return screen.respondsToSelector(#selector(UIScreen.displayLinkWithTarget(_:selector:))) && screen.scale >= 2.0
    }
    /**
     *  Check if the current device has a Retina HD display
     */
    public static func isRetinaHD() -> Bool {
        let screen = UIScreen.mainScreen()
        return screen.respondsToSelector(#selector(UIScreen.displayLinkWithTarget(_:selector:))) && screen.scale >= 3.0
    }
    
    /**
     *  The current device RAM size
     */
    public static func ramSize() -> Int {
        return self.p_systemInfomation(HW_MEMSIZE)
    }
    
    /**
     *  The current device CPU number
     */
    public static func cpuNumber() -> Int {
        return self.p_systemInfomation(HW_NCPU)
    }
    
    /**
     *  The current device total memory
     */
    public static func totalMemory() -> Int {
        return self.p_systemInfomation(HW_PHYSMEM)
    }
    
    /**
     *  The current device non-kernel memory
     */
    public static func userMemory() -> Int {
        return self.p_systemInfomation(HW_USERMEM)
    }
    
    /**
     *  The current device total disk space
     */
    public static func totalDiskSpace() -> Int {
        do {
            let fattributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory())
            return (fattributes[NSFileSystemSize] as! NSNumber).integerValue
        }
        catch let error as NSError {
            dLog(error)
        }
        return 0
    }
    
    /**
     *  The current device free disk space
     */
    public static func freeDiskSpace() -> Int {
        do {
            let fattributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory())
            return (fattributes[NSFileSystemFreeSize] as! NSNumber).integerValue
        }
        catch let error as NSError {
            dLog(error)
        }
        return 0
    }
    
    /**
     *  The current device MAC address
     */
    public static func macAddress() -> String {
        let index  = Int32(if_nametoindex("en0"))
        let bsdData = "en0".dataUsingEncoding(NSUTF8StringEncoding)!
        var mib : [Int32] = [CTL_NET, AF_ROUTE, 0, AF_LINK, NET_RT_IFLIST, index]
        var len = 0;
        if sysctl(&mib,UInt32(mib.count), nil, &len,nil,0) < 0 {
            dLog("Error: could not determine length of info data structure ")
            return ""
        }
        var buffer = [CChar](count: len, repeatedValue: 0)
        if sysctl(&mib, UInt32(mib.count), &buffer, &len, nil, 0) < 0 {
            dLog("Error: could not read info data structure")
            return ""
        }        
        let infoData = NSData(bytes: buffer, length: len)
        var interfaceMsgStruct = if_msghdr()
        infoData.getBytes(&interfaceMsgStruct, length: sizeof(if_msghdr))
        let socketStructStart = sizeof(if_msghdr) + 1
        let socketStructData = infoData.subdataWithRange(NSMakeRange(socketStructStart, len - socketStructStart))
        let rangeOfToken = socketStructData.rangeOfData(bsdData, options: NSDataSearchOptions(rawValue: 0), range: NSMakeRange(0, socketStructData.length))
        let macAddressData = socketStructData.subdataWithRange(NSMakeRange(rangeOfToken.location + 3, 6))
        var macAddressDataBytes = [UInt8](count: 6, repeatedValue: 0)
        macAddressData.getBytes(&macAddressDataBytes, length: 6)
        return macAddressDataBytes.map({ String(format:"%02x", $0) }).joinWithSeparator(":")
    }
    
    /**
     *  Generate an unique identifier and store it into standardUserDefaults
     */
    public static func uniqueIdentifier() -> String {
        var uuid: String = ""
        if UIDevice.currentDevice().respondsToSelector(Selector("identifierForVendor")) {
            uuid = (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
        } else {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let saved = defaults.objectForKey(UniqueIdentifierDefaultsKey) {
                uuid = saved as! String
            } else {
                uuid = self.p_generateUUID()
                defaults.setObject(uuid, forKey: UniqueIdentifierDefaultsKey)
            }
        }
        return uuid
    }
    
    //  Private
    private static func p_systemInfomation(type: Int32) -> Int {
        var size: size_t = sizeof(Int)
        var results: Int = 0
        var mib: [Int32] = [CTL_HW, type]
        sysctl(&mib, 2, &results, &size, nil, 0)
        return results
    }
    
    private static func p_generateUUID() -> String {
        var uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
        if uuidRef != nil {
            uuidRef = nil
        }
        var uuid = ""
        if uuidStringRef != nil {
            uuid = uuidStringRef! as String
        }
        return uuid
    }
}