//
//  AskParrotAPI.swift
//  Pods
//
//  Created by Hemant Singh on 17/02/17.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

public class AskParrotAPI {
    
    func requestCall(to: String, after:NSNumber, completion: @escaping (AskParrotResponse) -> Swift.Void)  {
        Alamofire.request(Router.RequestCall(callQuery.init(phone: to).toDictionary() as! [String : AnyObject])).responseSwiftyJSON { (response) in
            switch response.result {
            case .success(let json):
                print("JSON: \(json)")
                if json["status"].intValue == 200 {
                    completion(.Success(""))
                }
                else{
                    completion(.Error(""))
                }
            case .failure(let error):
                print(error)
                completion(.Error(""))
            }
        }
    }
}
enum AskParrotResponse {
    case Success(String)
    case Error(String)
}
