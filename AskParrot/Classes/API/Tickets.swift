//
//  Tickets.swift
//  Pods
//
//  Created by Hemant Singh on 11/02/17.
//
//

import UIKit
import SwiftyJSON

class Tickets : NSObject, NSCoding{
    
    var data : [Ticket]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init() {
        data = []
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [Ticket]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = Ticket(fromJson: dataJson)
            data.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if data != nil{
            var dictionaryElements = [NSDictionary]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [Ticket]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        
    }
    
}
class Ticket : NSObject, NSCoding{
    
    var appId : String!
    var companyId : String!
    var createdAt : String!
    var createdby : String!
    var id : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appId = json["appId"].stringValue
        companyId = json["companyId"].stringValue
        createdAt = json["createdAt"].stringValue
        createdby = json["createdby"].stringValue
        id = json["id"].stringValue
        title = json["title"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if appId != nil{
            dictionary["appId"] = appId
        }
        if companyId != nil{
            dictionary["companyId"] = companyId
        }
        if createdAt != nil{
            dictionary["createdAt"] = createdAt
        }
        if createdby != nil{
            dictionary["createdby"] = createdby
        }
        if id != nil{
            dictionary["id"] = id
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
        appId = aDecoder.decodeObject(forKey: "appId") as? String
        companyId = aDecoder.decodeObject(forKey: "companyId") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        createdby = aDecoder.decodeObject(forKey: "createdby") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if appId != nil{
            aCoder.encode(appId, forKey: "appId")
        }
        if companyId != nil{
            aCoder.encode(companyId, forKey: "companyId")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if createdby != nil{
            aCoder.encode(createdby, forKey: "createdby")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
