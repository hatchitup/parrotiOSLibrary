//
//  AskParrot.swift
//  Pods
//
//  Created by Hemant Singh on 08/02/17.
//
//

import Foundation


public class AskParrot {

    static let defaults: UserDefaults = UserDefaults(suiteName: "com.askparrot")!
    
    public static func configure(appId: String){
        defaults.set(appId, forKey: APUDKeys.appIDkey.rawValue)
        defaults.synchronize()
    }
    public static func getAppId() -> String {
        return defaults.string(forKey: APUDKeys.appIDkey.rawValue)!
    }
     static func isPad() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
     static func isPhone() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
enum APUDKeys : String {
    case appIDkey = "AskParrotAppID"
    case tokenKey = "AskParrotToken"
}