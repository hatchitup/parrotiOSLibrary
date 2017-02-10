//
//  ColorUtil.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import UIKit

class ColorUtil {
    static func configColorFromHex(hex: String?, orDefault defaultColor: UIColor) -> UIColor {
        if let hex = hex {
            return UIColor.colorFromHexString(hex: hex)
        } else {
            return defaultColor
        }
    }
}
