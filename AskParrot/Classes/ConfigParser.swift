//
//  ConfigParser.swift


import UIKit

class ConfigParser {

    func parse(data: NSData) throws  -> Config{
        let defaultConfig = Config()
        
        let configDictionary: NSDictionary = try JSONSerialization.jsonObject(with: data as Data,
            options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        let id = configDictionary["appId"] as? String
        let navigationBarColor = ColorUtil.configColorFromHex(hex: configDictionary["navigationBarColor"] as? String,
            orDefault: defaultConfig.navigationBarColor)
        let navigationBarTextColor = ColorUtil.configColorFromHex(hex: configDictionary["navigationBarTextColor"] as? String,
            orDefault: defaultConfig.navigationBarTextColor)
        let backgroundColor = ColorUtil.configColorFromHex(hex: configDictionary["backgroundColor"] as? String,
            orDefault: defaultConfig.backgroundColor)
        let roundedImages = configDictionary["roundedImages"] as? Bool ?? defaultConfig.roundedImages
        return Config(id: id!,navigationBarColor: navigationBarColor, navigationBarTextColor: navigationBarTextColor, backgroundColor: backgroundColor, roundedImages: roundedImages)
    }
}
