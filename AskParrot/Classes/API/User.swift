
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import SwiftyJSON


class User : NSObject, NSCoding{
    
    var authToken : String!
    var email : String!
    var id : String!
    var location : String!
    var name : String!
    var phone : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init() {
        
    }
    init(name: String,phone: String, email: String, location: String) {
        self.name = name
        self.email = email
        self.location = location
        self.phone = phone
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        authToken = json["data"]["authToken"].stringValue
        email = json["data"]["email"].stringValue
        id = json["data"]["id"].stringValue
        location = json["data"]["location"].stringValue
        name = json["data"]["name"].stringValue
        phone = json["data"]["phone"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if authToken != nil{
            dictionary["authToken"] = authToken
        }
        if email != nil{
            dictionary["email"] = email
        }
        if id != nil{
            dictionary["id"] = id
        }
        if location != nil{
            dictionary["location"] = location
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        authToken = aDecoder.decodeObject(forKey: "authToken") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        location = aDecoder.decodeObject(forKey: "location") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if authToken != nil{
            aCoder.encode(authToken, forKey: "authToken")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        
    }
    
}
