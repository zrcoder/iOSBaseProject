//
//  DeviceHelper.swift
//  iOSBaseProject
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

let UniqueIdentifierDefaultsKey = "UniqueIdentifierDefaultsKey"
class DeviceHelper {
    /**
     *  The system version without the subversion
     *  Example: 7.0
     */
    static func systemVersion() -> String {
        return UIDevice.currentDevice().systemVersion as String
    }
    
    /**
     *  The device platform string
     *  Example: "iPhone3,2"
     */
    static func platform() -> String {
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
    static func platformForUser() -> String {
        let platform = self.platform()
        if let result = p_platformMap[platform] {
            return result
        }
        return platform;
    }
    /**
     *  Check if the current device is an iPhone
     */
    static func isiPhone() -> Bool {
        return self.platform().hasPrefix("iPhone")
    }
    /**
     *  Check if the current device is an iPad
     */
    static func isiPad() -> Bool {
        return self.platform().hasPrefix("iPad")
    }
    /**
     *  Check if the current device is an iPod
     */
    static func isiPod() -> Bool {
        return self.platform().hasPrefix("iPod")
    }
    /**
     *  Check if the current device is the simulator
     */
    static func isSimulator() -> Bool {
        return self.platform() == "i386" || self.platform() == "x86_64"
    }
    /**
     *  Check if the current device has a Retina display
     */
    static func isRetina() -> Bool {
        let screen = UIScreen.mainScreen()
        return screen.respondsToSelector(#selector(UIScreen.displayLinkWithTarget(_:selector:))) && screen.scale >= 2.0
    }
    /**
     *  Check if the current device has a Retina HD display
     */
    static func isRetinaHD() -> Bool {
        let screen = UIScreen.mainScreen()
        return screen.respondsToSelector(#selector(UIScreen.displayLinkWithTarget(_:selector:))) && screen.scale >= 3.0
    }
    
    /**
     *  The current device RAM size
     */
    static func ramSize() -> Int {
        return self.p_systemInfomation(HW_MEMSIZE)
    }
    
    /**
     *  The current device CPU number
     */
    static func cpuNumber() -> Int {
        return self.p_systemInfomation(HW_NCPU)
    }
    
    /**
     *  The current device total memory
     */
    static func totalMemory() -> Int {
        return self.p_systemInfomation(HW_PHYSMEM)
    }
    
    /**
     *  The current device non-kernel memory
     */
    static func userMemory() -> Int {
        return self.p_systemInfomation(HW_USERMEM)
    }
    
    /**
     *  The current device total disk space
     */
    static func totalDiskSpace() -> Int {
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
    static func freeDiskSpace() -> Int {
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
    static func macAddress() -> String {
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
    static func uniqueIdentifier() -> String {
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
    
    private static let p_platformMap = [
        //  iPhone
        "iPhone1,1": "iPhone 2G",
        "iPhone1,2": "iPhone 3G",
        "iPhone2,1": "iPhone 3GS",
        "iPhone3,1": "iPhone 4",
        "iPhone3,3": "iPhone 4 (CDMA)",
        "iPhone4,1": "iPhone 4S",
        "iPhone5,1": "iPhone 5 (GSM)",
        "iPhone5,2": "iPhone 5 (CDMA)",
        "iPhone5,3": "iPhone 5C (GSM)",
        "iPhone5,4": "iPhone 5C (Global)",
        "iPhone6,1": "iPhone 5S (GSM)",
        "iPhone6,2": "iPhone 5S (Global)",
        "iPhone7,1": "iPhone 6 Plus",
        "iPhone7,2": "iPhone 6",
        "iPhone8,1": "iPhone 6s",
        "iPhone8,2": "iPhone 6s Plus",
        //  iPod
        "iPod1,1": "iPod Touch 1G",
        "iPod2,1": "iPod Touch 2G",
        "iPod3,1": "iPod Touch 3G",
        "iPod4,1": "iPod Touch 4G",
        "iPod5,1": "iPod Touch 5G",
        //  iPad
        "iPad1,1": "iPad 1",
        "iPad2,1": "iPad 2 (WiFi)",
        "iPad2,2": "iPad 2 (GSM)",
        "iPad2,3": "iPad 2 (CDMA)",
        "iPad2,4": "iPad 2 (32nm)",
        "iPad2,5": "iPad mini (WiFi)",
        "iPad2,6": "iPad mini (GSM)",
        "iPad2,7": "iPad mini (CDMA)",
        "iPad3,1": "iPad 3 (WiFi)",
        "iPad3,2": "iPad 3 (CDMA)",
        "iPad3,3": "iPad 3 (GSM)",
        "iPad3,4": "iPad 4 (WiFi)",
        "iPad3,5": "iPad 4 (GSM)",
        "iPad3,6": "iPad 4 (CDMA)",
        "iPad4,1": "iPad Air (WiFi)",
        "iPad4,2": "iPad Air (Cellular)",
        "iPad4,3": "iPad Air (China)",
        "iPad4,4": "iPad mini 2 (WiFi)",
        "iPad4,5": "iPad mini 2 (Cellular)",
        "iPad4,6": "iPad mini 2 (China)",
        "iPad4,7": "iPad mini 3 (WiFi)",
        "iPad4,8": "iPad mini 3 (Cellular)",
        "iPad4,9": "iPad mini 3 (China)",
        "iPad5,3": "iPad Air 2 (WiFi)",
        "iPad5,4": "iPad Air 2 (Cellular)",
        //  simulator
        "i386": "Simulator (iPhone)",
        "x86_64": "Simulator (iPad)"
    ]
}