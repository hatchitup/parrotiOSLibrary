//  MIT License

//  Copyright (c) 2017 Haik Aslanyan

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


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
    Alamofire.request(Router.GetUser(userQuery.init(value: forUserID).toDictionary() as! [String : AnyObject])).responseJSON { (response) in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
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
