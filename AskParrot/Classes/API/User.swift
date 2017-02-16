//
//  Created by Hemant Singh on 10/02/17.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class User: NSObject {
    
    //MARK: Properties
    let name: String
    let id: String
    var profilePic: UIImage
    
    //MARK: Methods
    
   class func info(forUserID: String, completion: @escaping (User) -> Swift.Void) {
    Alamofire.request(Router.GetUser(userQuery.init(value: forUserID).toDictionary() as! [String : AnyObject])).responseSwiftyJSON { (response) in
        switch response.result {
        case .success(let json):
            print("JSON: \(json)")
            if json["data"] != nil {
                let name = json["data"]["name"].stringValue
                let link = URL.init(string: json["data"]["avatar"].stringValue)
                URLSession.shared.dataTask(with: link!, completionHandler: { (data, response, error) in
                    if error == nil {
                        let profilePic = UIImage.init(data: data!)
                        let user = User.init(name: name, id: forUserID, profilePic: profilePic!)
                        completion(user)
                    }
                }).resume()
            }
        case .failure(let error):
            print(error)
        }
    }
    }
    
    //MARK: Inits
    init(name: String, id: String, profilePic: UIImage) {
        self.name = name
        self.id = id
        self.profilePic = profilePic
    }
}
class userQuery: NSObject{
    var queryOn : String!
    init( value: String) {
        self.queryOn = value
        
    }
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if queryOn != nil{
            dictionary["userId"] = queryOn
        }
        return dictionary
    }
    
}
