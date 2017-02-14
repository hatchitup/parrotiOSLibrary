//
//  APQuery.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import UIKit
import SwiftyJSON

class APQuery : NSObject, NSCoding{
    
    var message : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(msg: String) {
        message = msg
        title = msg
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        title = json["title"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if message != nil{
            dictionary["message"] = message
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        message = aDecoder.decodeObject(forKey: "message") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
class callQuery  : NSObject, NSCoding{
    
    var phone : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(phone: String) {
        super.init()
        self.phone = phone
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        phone = json["phone"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
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
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        
    }
    
}
