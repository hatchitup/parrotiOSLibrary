//
//  AskParrot.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class AskParrot {

    static let defaults: UserDefaults = UserDefaults(suiteName: "com.askparrot")!
    
    static func parrotPing(){
        Alamofire.request(Router.Ping()).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                let user = APUser.init(fromJson: JSON(response.data))
                AskParrot.setToken(token: user.authToken)
                PersistencyManager.saveUser(user: user)
            case .failure(let error):
                print(error)
            }
        })
    }
    public static func setToken(token: String){
        defaults.set(token, forKey: APUDKeys.tokenKey.rawValue)
        defaults.synchronize()
    }
    public static func getToken() -> String {
        return defaults.string(forKey: APUDKeys.tokenKey.rawValue) ?? ""
    }
}
enum APUDKeys : String {
    case appIDkey = "AskParrotAppID"
    case tokenKey = "AskParrotToken"
}
