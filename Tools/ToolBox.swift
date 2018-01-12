//
//  ToolBox.swift
//  AutoLayoutProject
//
//  Created by 黄穆斌 on 2017/3/18.
//  Copyright © 2017年 MuBinHuang. All rights reserved.
//

import UIKit
import Photos


// MARK: - ToolBox

public class ToolBox {
    
    // MARK: - Random Number
    
    /**
     count a random number in range
     */
    public class func random(range: Range<Int>) -> Int {
        return  Int(arc4random_uniform(UInt32(range.count))) + range.lowerBound
    }
    
    /**
     count a random number in 0 ..< 1
     */
    public class func random() -> Double {
        return Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
    }
    
    // MARK: - Device Model
    
    /**
     check the current device is't iPhone.
     */
    public class func isiPhone() -> Bool {
        return UIDevice.current.model.hasPrefix("iPhone")
    }
    
    /**
     check the current device is't iPad.
     */
    public class func isiPad() -> Bool {
        return UIDevice.current.model.hasPrefix("iPad")
    }
    
    
    /**
     Get the current device version
     */
    public class func device_version() -> String {
        var system_info = utsname()
        uname(&system_info)
        var machine = [Int8]()
        if system_info.machine.0 != 0 {
            machine.append(system_info.machine.0)
        }
        if system_info.machine.1 != 0 {
            machine.append(system_info.machine.1)
        }
        if system_info.machine.2 != 0 {
            machine.append(system_info.machine.2)
        }
        if system_info.machine.3 != 0 {
            machine.append(system_info.machine.3)
        }
        if system_info.machine.4 != 0 {
            machine.append(system_info.machine.4)
        }
        if system_info.machine.5 != 0 {
            machine.append(system_info.machine.5)
        }
        if system_info.machine.6 != 0 {
            machine.append(system_info.machine.6)
        }
        if system_info.machine.7 != 0 {
            machine.append(system_info.machine.7)
        }
        if system_info.machine.8 != 0 {
            machine.append(system_info.machine.8)
        }
        if system_info.machine.9 != 0 {
            machine.append(system_info.machine.9)
        }
        if let string = String(cString: machine, encoding: String.Encoding.utf8) {
            switch string {
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
            case "iPhone4,1": return "iPhone 4S"
            case "iPhone5,1": return "iPhone 5"
            case "iPhone5,2": return "iPhone 5 (GSM+CDMA)"
            case "iPhone5,3": return "iPhone 5c (GSM)"
            case "iPhone5,4": return "iPhone 5c (GSM+CDMA)"
            case "iPhone6,1": return "iPhone 5s (GSM)"
            case "iPhone6,2": return "iPhone 5s (GSM+CDMA)"
            case "iPhone7,1": return "iPhone 6 Plus"
            case "iPhone7,2": return "iPhone 6"
            case "iPhone8,1": return "iPhone 6s"
            case "iPhone8,2": return "iPhone 6s Plus"
            case "iPhone8,4": return "iPhone SE"
                
            case "iPod1,1": return "iPod Touch 1G"
            case "iPod2,1": return "iPod Touch 2G"
            case "iPod3,1": return "iPod Touch 3G"
            case "iPod4,1": return "iPod Touch 4G"
            case "iPod5,1": return "iPod Touch (5 Gen)"
                
            case "iPad1,1": return "iPad"
            case "iPad1,2": return "iPad 3G"
            case "iPad2,1": return "iPad 2 (WiFi)"
            case "iPad2,2", "iPad2,4": return "iPad 2"
            case "iPad2,3": return "iPad 2 (CDMA)"
            case "iPad2,5": return "iPad Mini (WiFi)"
            case "iPad2,6": return "iPad Mini"
            case "iPad2,7": return "iPad Mini (GSM+CDMA)"
            case "iPad3,1": return "iPad 3 (WiFi)"
            case "iPad3,2": return "iPad 3 (GSM+CDMA)"
            case "iPad3,3": return "iPad 3"
            case "iPad3,4": return "iPad 4 (WiFi)"
            case "iPad3,5": return "iPad 4"
            case "iPad3,6": return "iPad 4 (GSM+CDMA)"
            case "iPad4,1": return "iPad Air (WiFi)"
            case "iPad4,2": return "iPad Air (Cellular)"
            case "iPad4,4": return "iPad Mini 2 (WiFi)"
            case "iPad4,5": return "iPad Mini 2 (Cellular)"
            case "iPad4,6": return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
            case "iPad5,1": return "iPad Mini 4 (WiFi)"
            case "iPad5,2": return "iPad Mini 4 (LTE)"
            case "iPad5,3", "iPad5,4": return "iPad Air 2"
            case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
            case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"
                
            case "i386", "x86_64": return "Simulator"
            default: break
            }
        }
        return "Apple"
    }
    
    /** get device name */
    public class func device_name() -> String {
        return UIDevice.current.name
    }
    
    /** get system version */
    public class func system_version() -> String {
        return UIDevice.current.systemVersion
    }
    
    /** Device uuid */
    public class func device_uuid() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    // MARK: - interface orientation
    
    /** Check the device is protrait? */
    public class func isProtrait() -> Bool {
        return UIScreen.main.bounds.width < UIScreen.main.bounds.height
    }
    
    /** Change the orientation to new. */
    public class func orientation_changed(to: UIInterfaceOrientation) {
        UIDevice.current.setValue(to.rawValue, forKey: "orientation")
        UIApplication.shared.statusBarOrientation = to
    }
    
    // MARK: - Capture Screen
    
    /** Capture view */
    public class func screen(view: UIView) -> UIImage? {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    /** Capture controller */
    public class func screen(controller: UIViewController) -> UIImage? {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            controller.navigationController?.view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - App Infos
    
    /** Get the app version */
    public class func app_version() -> String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "Version default"
    }
    
    
    // MARK: - Time
    
    /** 获取当前时区的偏移量 */
    public class func timezone_offset() -> Double {
        let zone = TimeZone.current
        let offset = zone.secondsFromGMT(for: Date())
        //print("Time Zone = \(zone); offset = \(offset)")
        return Double(offset)
    }
    
    /** 时间格式化 */
    public class func minute(time: TimeInterval) -> String {
        var str = ""
        let min = Int(time) / 60
        if min >= 10 {
            str += "\(min)"
        } else {
            str += "0\(min)"
        }
        
        let sec = Int(time) % 60
        if sec >= 10 {
            str += ":\(sec)"
        } else {
            str += ":0\(sec)"
        }
        return str
    }
    
    
    // MARK: - 保存图片和视频到本地相册
    
    /** 保存图片到手机相册 */
    class func save_image_to_iPhone_album(image: UIImage, complete: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let _ = PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: complete)
    }
    
    /** 保存图片到手机相册 */
    class func save_image_to_iPhone_album(image_url: URL, complete: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let _ = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: image_url)
        }, completionHandler: complete)
    }
    
    /** 保存视频到手机相册 */
    class func save_video_to_iPhone_album(video_url: URL, complete: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let _ = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: video_url)
        }, completionHandler: complete)
    }
    
    
}
