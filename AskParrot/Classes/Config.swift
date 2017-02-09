//
//  Config.swift
//  Pods
//
//  Created by Hemant Singh on 07/02/17.
//
//

import Foundation
import UIKit

class Config {
    
    let appID: String
    let navigationBarColor: UIColor
    let navigationBarTextColor: UIColor
    let backgroundColor: UIColor
    let roundedImages: Bool

    
    init() {
        appID = ""
        navigationBarColor = UIColor.white
        navigationBarTextColor = UIColor.black
        backgroundColor = UIColor.white
        roundedImages = true
    }
    
    init(id: String, navigationBarColor: UIColor, navigationBarTextColor: UIColor, backgroundColor: UIColor, roundedImages: Bool) {
        self.appID = id
        self.navigationBarColor = navigationBarColor
        self.navigationBarTextColor = navigationBarTextColor
        self.backgroundColor = backgroundColor
        self.roundedImages = roundedImages
    }
}

struct APUser {
    let name: String?
    let email: String?
    let phone: String?

}
